defmodule Day09Part1 do
  @moduledoc """

  Example:\
  {{4,2}, {4,1}} first tuple is position of head, second tuple is position of tail
  difference vector is {0, -1}

  ......
  ....H.
  ....T.
  ......

  """
  def sample do
    content = File.read!("data/day_09/sample.txt")
    doit(content)
  end

  def puzzle do
    content = File.read!("data/day_09/puzzle.txt")
    {uSecs, result} = :timer.tc(Day09Part1, :doit, [content])
    IO.puts("It took #{uSecs / 1_000_000} seconds to get the result")
    result
  end

  def diff_between_points(current_position) do
    {
      at(current_position, 1, 0) - at(current_position, 0, 0),
      at(current_position, 1, 1) - at(current_position, 0, 1)
    }
  end

  def at(p, x, y), do: p |> elem(x) |> elem(y)

  def move(acc, direction, diff) do
    positions = acc.positions
    visited = acc.visited

    tail_move = tail_move_from_diff(diff, direction)

    tail_position =
      {at(positions, 1, 0) + elem(tail_move, 0), at(positions, 1, 1) + elem(tail_move, 1)}

    head_position = move_head(positions, direction)

    visited = MapSet.put(visited, tail_position)

    %{
      :positions => {
        head_position,
        {at(positions, 1, 0) + elem(tail_move, 0), at(positions, 1, 1) + elem(tail_move, 1)}
      },
      :visited => visited
    }
  end

  def move_head(p, :r), do: {at(p, 0, 0) + 1, at(p, 0, 1) + 0}
  def move_head(p, :u), do: {at(p, 0, 0) + 0, at(p, 0, 1) + 1}
  def move_head(p, :l), do: {at(p, 0, 0) - 1, at(p, 0, 1) + 0}
  def move_head(p, :d), do: {at(p, 0, 0) + 0, at(p, 0, 1) - 1}

  # {0, 0}
  def tail_move_from_diff({0, 0}, :r), do: {0, 0}
  def tail_move_from_diff({0, 0}, :u), do: {0, 0}
  def tail_move_from_diff({0, 0}, :l), do: {0, 0}
  def tail_move_from_diff({0, 0}, :d), do: {0, 0}

  # {-1, 0}
  def tail_move_from_diff({-1, 0}, :r), do: {1, 0}
  def tail_move_from_diff({-1, 0}, :u), do: {0, 0}
  def tail_move_from_diff({-1, 0}, :l), do: {0, 0}
  def tail_move_from_diff({-1, 0}, :d), do: {0, 0}

  # {-1, -1}
  def tail_move_from_diff({-1, -1}, :r), do: {1, 1}
  def tail_move_from_diff({-1, -1}, :u), do: {1, 1}
  def tail_move_from_diff({-1, -1}, :l), do: {0, 0}
  def tail_move_from_diff({-1, -1}, :d), do: {0, 0}

  # {0, -1}
  def tail_move_from_diff({0, -1}, :r), do: {0, 0}
  def tail_move_from_diff({0, -1}, :u), do: {0, 1}
  def tail_move_from_diff({0, -1}, :l), do: {0, 0}
  def tail_move_from_diff({0, -1}, :d), do: {0, 0}

  # {1, -1}
  def tail_move_from_diff({1, -1}, :r), do: {0, 0}
  def tail_move_from_diff({1, -1}, :u), do: {-1, 1}
  def tail_move_from_diff({1, -1}, :l), do: {-1, 1}
  def tail_move_from_diff({1, -1}, :d), do: {0, 0}

  # {1, 0}
  def tail_move_from_diff({1, 0}, :r), do: {0, 0}
  def tail_move_from_diff({1, 0}, :u), do: {0, 0}
  def tail_move_from_diff({1, 0}, :l), do: {-1, 0}
  def tail_move_from_diff({1, 0}, :d), do: {0, 0}

  # {1, 1}
  def tail_move_from_diff({1, 1}, :r), do: {0, 0}
  def tail_move_from_diff({1, 1}, :u), do: {0, 0}
  def tail_move_from_diff({1, 1}, :l), do: {-1, -1}
  def tail_move_from_diff({1, 1}, :d), do: {-1, -1}

  # {0, 1}
  def tail_move_from_diff({0, 1}, :r), do: {0, 0}
  def tail_move_from_diff({0, 1}, :u), do: {0, 0}
  def tail_move_from_diff({0, 1}, :l), do: {0, 0}
  def tail_move_from_diff({0, 1}, :d), do: {0, -1}

  # {-1, 1}
  def tail_move_from_diff({-1, 1}, :r), do: {1, -1}
  def tail_move_from_diff({-1, 1}, :u), do: {0, 0}
  def tail_move_from_diff({-1, 1}, :l), do: {0, 0}
  def tail_move_from_diff({-1, 1}, :d), do: {1, -1}

  def doit(input) do
    input
    |> get_single_moves()
    |> Enum.reduce(%{:positions => {{0, 0}, {0, 0}}, :visited => MapSet.new()}, fn direction,
                                                                                   acc ->
      move(acc, direction, diff_between_points(acc.positions))
    end)
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
