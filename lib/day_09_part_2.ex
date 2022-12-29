defmodule Day09Part2 do

  def sample do
    content = File.read!("data/day_09/sample.txt")
    doit(content)
  end

  def sample_2 do
    content = File.read!("data/day_09/sample_2.txt")
    doit(content)
  end

  def puzzle do
    content = File.read!("data/day_09/puzzle.txt")
    {uSecs, result} = :timer.tc(Day09Part2, :doit, [content])
    IO.puts("It took #{uSecs / 1_000_000} seconds to get the result")
    result
  end

  def diff_between_points(head, tail) do
    {
      elem(tail, 0) - elem(head, 0),
      elem(tail, 1) - elem(head, 1)
    }
  end

  def knot_move(diff) do
    case diff do
      {-2, 0} -> {1, 0}
      {-2, 1} -> {1, -1}
      {-2, -1 } -> {1, 1}

      {-1, 2} -> {1, -1}
      {0, 2} -> {0, -1}
      {1, 2} -> {-1, -1}

      {2, 1} -> {-1, -1}
      {2, 0} -> {-1, 0}
      {2, -1} -> {-1, 1}

      {1, -2} -> {-1, 1}
      {0, -2} -> {0, 1}
      {-1, -2} -> {1, 1}

      {-2, -2} -> {1, 1}
      {2, -2} -> {-1, 1}
      {-2, 2} -> {1, -1}
      {2, 2} -> {-1, -1}

      _ -> {0, 0}

    end
  end

  def move_rope(acc, direction) do
    [head | rest] = acc.positions
    new_head_position = move_head(head, direction)
    prev_positions = [new_head_position | rest]

    new_positions = Enum.reduce(prev_positions, %{:prev => new_head_position, :positions => []}, fn knot, acc ->
      diff = diff_between_points(acc.prev, knot)
      knot_move = knot_move(diff)
      knot_position = {elem(knot, 0) + elem(knot_move, 0), elem(knot, 1) + elem(knot_move, 1)}
      %{:positions => [knot_position | acc.positions], :prev => knot_position}
    end)

    visited = MapSet.put(acc.visited, List.first(new_positions.positions))
    %{:positions => Enum.reverse(new_positions.positions), :visited => visited}
  end

  def move_head(p, :r), do: {elem(p, 0) + 1, elem(p, 1) + 0}
  def move_head(p, :u), do: {elem(p, 0) + 0, elem(p, 1) + 1}
  def move_head(p, :l), do: {elem(p, 0) - 1, elem(p, 1) + 0}
  def move_head(p, :d), do: {elem(p, 0) + 0, elem(p, 1) - 1}

  def doit(input) do
    input
    |> get_single_moves()
    |> Enum.reduce(
      %{:positions => List.duplicate({0, 0}, 10), :visited => MapSet.new(), :step => 0},
      fn direction, acc ->
        move_rope(acc, direction)
      end
    )
    |> Map.get(:visited)
    |> MapSet.size()
  end

  def get_list_of_moves(direction, num), do: List.duplicate(direction, String.to_integer(num))

  def get_single_moves(input) do
    input
    |> String.split("\n")
    |> Enum.reduce([], fn
      "", acc -> acc
      "U " <> num, acc -> [acc | get_list_of_moves(:u, num)]
      "R " <> num, acc -> [acc | get_list_of_moves(:r, num)]
      "D " <> num, acc -> [acc | get_list_of_moves(:d, num)]
      "L " <> num, acc -> [acc | get_list_of_moves(:l, num)]
    end)
    |> List.flatten()
  end
end
