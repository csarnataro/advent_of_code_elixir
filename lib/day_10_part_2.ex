defmodule Day10Part2 do


    # def doit_(content) do

    #   acc = %{
    #     :cycle => 0,
    #     :register => 1,
    #     :matrix => ""
    #   }

    #   "noop\n" <> content
    #   |> String.split("\n")
    #   |> Enum.map(fn
    #     "noop" -> "noop\n"
    #     "addx " <> value -> "addx 0\naddx " <> value <> "\n"
    #     "" -> ""
    #   end)
    #   |> Enum.join("")
    #   |> String.split("\n")
    #   |> Enum.reduce(acc, fn op, acc ->

    #     {cycle, register} = process_line(op, acc.cycle, acc.register)
    #     IO.write("at cycle #{cycle} #{rem(cycle,40)} the register is #{register}, should write ")
    #     matrix = if rem(cycle, 40) >= register && rem(cycle, 40) <= register + 2 do
    #       IO.puts("#")
    #       acc.matrix <> "#"
    #     else
    #       IO.puts(".")
    #       acc.matrix <> "."
    #     end

    #     matrix = if (rem(cycle, 40) == 0), do: matrix <> "  ", else: matrix

    #     %{
    #       :cycle => cycle,
    #       :register => register,
    #       :matrix => matrix
    #     }

    #   end)
    #   |> IO.inspect()
    #   |> Map.fetch!(:matrix)
    # end

  defmodule CPU do
    def receive_message(from, acc) do
      %{
        :cycle => cycle,
        :register => register,
        :next_value => next_value,
      } = acc

      new_acc =
        receive do
          {:exit} ->
            send(from, {:got_solution, acc.matrix})
            :got_solution

          {:addx, value} ->
            new_matrix = if rem(cycle, 40) >= register && rem(cycle, 40) <= register + 2 do
              acc.matrix <> "#"
            else
              acc.matrix <> "."
            end
            %{
              :cycle => cycle + 1,
              :register => register,
              :next_value => value,
              :matrix => new_matrix <> (if (rem(cycle, 40) == 0), do: "\n", else: "")
            }

          {:end_cycle} ->
            new_matrix = if rem(cycle , 40) >= register && rem(cycle, 40) <= register + 2 do
              acc.matrix <> "#"
            else
              acc.matrix <> "."
            end

            %{
              :cycle => cycle + 1,
              :register => register + next_value,
              :next_value => 0,
              :matrix => new_matrix <> (if (rem(cycle, 40) == 0), do: "\n", else: "")
            }

          {_} ->
            IO.puts("============= unknown message")
        end

      if new_acc != :got_solution do
        receive_message(from, new_acc)
      end
    end
  end

  def sample do
    content = File.read!("data/day_10/sample.txt")
    doit(content)
  end

  def puzzle do
    content = File.read!("data/day_10/puzzle.txt")
    doit(content)
  end

  def doit(content) do
    pid =
      spawn(CPU, :receive_message, [
        self(),
        %{:cycle => 1, :register => 1, :next_value => 0, :matrix => ""}
      ])

    content
    |> String.split("\n")
    |> Enum.map(fn
      "noop" ->
        send(pid, {:end_cycle})

      "addx " <> value ->
        send(pid, {:addx, String.to_integer(value)})
        send(pid, {:end_cycle})

      "" ->
        nil
    end)

    send(pid, {:exit})

    receive do
      {:got_solution, matrix} ->
        IO.puts("******** Solution is: ")
        IO.puts(matrix)
        matrix
    after 2000 -> nil
    end
  end
end
