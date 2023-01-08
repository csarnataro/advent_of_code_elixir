defmodule Day11Part1 do
  defmodule Monkey do
    def start_link(id, parent_pid, map) do
      Task.start_link(fn ->
        loop(%{
          :id => id,
          :parent_pid => parent_pid,
          :items => map.items,
          :down_level => fn level -> div(level, 3) end,
          :op => map.op,
          :condition => map.condition
        })
      end)
    end

    def process_items(map) do
      %{parent_pid: parent_pid, down_level: down_level, id: id, op: op, condition: condition} =
        map

      IO.puts("Monkey #{id}:")
      for item <- map.items do
        IO.puts("  Monkey inspects an item with a worry level of #{item}.")
        value = op.(item)
        IO.puts("    Worry level is (do op) to #{value}.")
        value = down_level.(value)
        IO.puts("    Monkey gets bored with item. Worry level is divided by 3 to #{value}.")
        {divisible, if_true, if_false} = condition
        next_monkey = if rem(value, divisible) == 0 do
          IO.puts("    Current worry level is divisible by #{divisible}.")
          IO.puts("    Item with worry level #{value} is thrown to monkey #{if_true}.")
          if_true
        else
          IO.puts("    Current worry level is not divisible by #{divisible}.")
          IO.puts("    Item with worry level #{value} is thrown to monkey #{if_false}.")
          if_false
        end
        IO.puts("")
        send(parent_pid, {:send_to_monkey, next_monkey, value})
      end

      if (length(map.items) > 0) do
        IO.write("Monkey #{id}: ")
        IO.inspect(map.items, charlists: :as_lists)
      end

      if (id == 3), do: IO.puts("")
      send(parent_pid, {:start_next_monkey, id})
    end

    def loop(map \\ %{}) do
      receive do
        {:start} ->
          process_items(map)
          loop(%{map | items: []})

        {:add_item, value} ->
          loop(%{map | items: map.items ++ [value]})

        {:inspect} ->
          send(map.parent_id, {:monkey_status, map})
          loop(map)

        {:exit} ->
          IO.puts("Monkey #{map.id} says: bye!")
          IO.inspect(map)

        {msg} ->
          IO.puts("Unknown message #{msg}")
          loop(map)
      end
    end
  end

  # alias Day11Part1.Monkey
  # @down_level = fn level -> div(level, 3)
  # {:cond, :then, :else} = condition
  # @if_as_func = fn condition, true_monkey, else_monkey -> if condition, do: true_monky, else: else_monkey en

  def sample do
    # content = File.read!("data/day_10/sample.txt")

    {:ok, pid_0} =
      Monkey.start_link(0, self(), %{
        :items => [79, 98],
        :op => fn old -> old * 19 end,
        :condition => {23, 2, 3}
      })

    {:ok, pid_1} =
      Monkey.start_link(1, self(), %{
        :items => [54, 65, 75, 74],
        :op => fn old -> old + 6 end,
        :condition => {19, 2, 0}
      })

    {:ok, pid_2} =
      Monkey.start_link(2, self(), %{
        :items => [79, 60, 97],
        :op => fn old -> old * old end,
        :condition => {13, 1, 3}
      })

    {:ok, pid_3} =
      Monkey.start_link(3, self(), %{
        :items => [74],
        :op => fn old -> old + 3  end,
        :condition => {17, 0, 1}
      })

    monkeys = %{
      0 => pid_0,
      1 => pid_1,
      2 => pid_2,
      3 => pid_3
    }

    send(Map.fetch!(monkeys, 0), {:start})

    process_incoming_messages(monkeys, 0)

    # doit(monkeys)
  end

  def process_incoming_messages(monkeys, cycle) do
    receive do
      {:start_next_monkey, id} ->
        cycle = if id == 0, do: cycle + 1, else: cycle
        next_monkey = try do
          rem(id + 1, map_size(monkeys))
        rescue
          ArithmeticError -> 0
        end

        if cycle <= 21 do
          send(Map.fetch!(monkeys, next_monkey), {:start})
          process_incoming_messages(monkeys, cycle)
        end
        # IO.puts("")

      {:send_to_monkey, id, value} ->
        send(Map.fetch!(monkeys, id), {:add_item, value})
        process_incoming_messages(monkeys, cycle)

      {msg} ->
        IO.puts("Unknown message #{msg}")
    end
  end

  # def puzzle do
  #   doit([])
  # end

  # def doit(monkeys) do
  #   for monkey <- monkeys do
  #     IO.inspect(monkey)
  #     existing_items = monkey.items
  #     monkeys[1] = %{ monkey | items: [ existing_items | 999] }
  #   end
  # end
end
