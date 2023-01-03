defmodule Day10Part1 do
  defmodule CPU do
    def receive_message(from, acc) do
      %{
        :cycle => cycle,
        :register => register,
        :next_value => next_value,
        :signal => signal
      } = acc

      new_acc =
        receive do
          {:exit} ->
            send(from, {:got_solution, acc.signal})
            :got_solution

          {:addx, value} ->
            %{
              :cycle => cycle + 1,
              :register => register,
              :next_value => value,
              :signal => check_signal(cycle, register, signal)
            }

          {:end_cycle} ->
            %{
              :cycle => cycle + 1,
              :register => register + next_value,
              :next_value => 0,
              :signal => check_signal(cycle, register, signal)
            }

          {_} ->
            IO.puts("============= unknown message")
        end

      if new_acc != :got_solution do
        receive_message(from, new_acc)
      end
    end

    def check_signal(cycle, register, signal) do
      if Enum.member?([20, 60, 100, 140, 180, 220], cycle) do
        signal + cycle * register
      else
        signal
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
        %{:cycle => 1, :register => 1, :next_value => 0, :signal => 0}
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
      {:got_solution, signal} ->
        IO.puts("******** Solution is: #{signal}")
        signal
    end
  end
end
