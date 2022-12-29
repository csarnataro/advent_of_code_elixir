defmodule Day09Part2 do
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

  def move(acc, direction) do
    positions = acc.positions

    old_head_position = Enum.at(positions, 0)
    new_head_position = move_head(old_head_position, direction)
    new_positions = [new_head_position]

    # all_moves = for current_position <- 1..9 do
    #   knot = Enum.at(positions, current_position)
    #   diff = diff_between_points(List.first(new_positions), knot)
    #   knot_move = knot_move(diff)
    #   knot_position = {elem(knot, 0) + elem(knot_move, 0), elem(knot, 1) + elem(knot_move, 1)}
    #   new_positions = [knot_position | new_positions]
    # end

    # new_positions = [new_positions | all_moves]

    # IO.puts("******** BEGIN: day_09_part_2:78 ********")
    # IO.inspect(new_positions)
    # IO.puts("********   END: day_09_part_2:78 ********")

    # # for current_position <- 1..9 do
    # #   knot = Enum.at(positions, current_position)
    # #   diff = diff_between_points(List.first(new_positions), knot)

    # #   knot_move = knot_move(diff)
    # #   knot_position = {elem(knot, 0) + elem(knot_move, 0), elem(knot, 1) + elem(knot_move, 1)}
    # #   new_positions = [knot_position | new_positions]
    # # end

    current_position = 1
    knot = Enum.at(positions, current_position)
    diff = diff_between_points(List.first(new_positions), knot)

    knot_move = knot_move(diff)
    knot_position = {elem(knot, 0) + elem(knot_move, 0), elem(knot, 1) + elem(knot_move, 1)}
    new_positions = [knot_position | new_positions]

    current_position = 2
    knot = Enum.at(positions, current_position)
    diff = diff_between_points(List.first(new_positions), knot)

    knot_move = knot_move(diff)
    knot_position = {elem(knot, 0) + elem(knot_move, 0), elem(knot, 1) + elem(knot_move, 1)}
    new_positions = [knot_position | new_positions]

    current_position = 3
    knot = Enum.at(positions, current_position)
    diff = diff_between_points(List.first(new_positions), knot)

    knot_move = knot_move(diff)
    knot_position = {elem(knot, 0) + elem(knot_move, 0), elem(knot, 1) + elem(knot_move, 1)}
    new_positions = [knot_position | new_positions]

    current_position = 4
    knot = Enum.at(positions, current_position)
    diff = diff_between_points(List.first(new_positions), knot)

    knot_move = knot_move(diff)
    knot_position = {elem(knot, 0) + elem(knot_move, 0), elem(knot, 1) + elem(knot_move, 1)}
    new_positions = [knot_position | new_positions]

    current_position = 5
    knot = Enum.at(positions, current_position)
    diff = diff_between_points(List.first(new_positions), knot)

    knot_move = knot_move(diff)
    knot_position = {elem(knot, 0) + elem(knot_move, 0), elem(knot, 1) + elem(knot_move, 1)}
    new_positions = [knot_position | new_positions]

    current_position = 6
    knot = Enum.at(positions, current_position)
    diff = diff_between_points(List.first(new_positions), knot)

    knot_move = knot_move(diff)
    knot_position = {elem(knot, 0) + elem(knot_move, 0), elem(knot, 1) + elem(knot_move, 1)}
    new_positions = [knot_position | new_positions]

    current_position = 7
    knot = Enum.at(positions, current_position)
    diff = diff_between_points(List.first(new_positions), knot)

    knot_move = knot_move(diff)
    knot_position = {elem(knot, 0) + elem(knot_move, 0), elem(knot, 1) + elem(knot_move, 1)}
    new_positions = [knot_position | new_positions]

    current_position = 8
    knot = Enum.at(positions, current_position)
    diff = diff_between_points(List.first(new_positions), knot)

    knot_move = knot_move(diff)
    knot_position = {elem(knot, 0) + elem(knot_move, 0), elem(knot, 1) + elem(knot_move, 1)}
    new_positions = [knot_position | new_positions]

    current_position = 9
    knot = Enum.at(positions, current_position)
    diff = diff_between_points(List.first(new_positions), knot)

    knot_move = knot_move(diff)
    knot_position = {elem(knot, 0) + elem(knot_move, 0), elem(knot, 1) + elem(knot_move, 1)}
    new_positions = [knot_position | new_positions]


    visited = MapSet.put(acc.visited, List.first(new_positions))
    %{:positions => Enum.reverse(new_positions), :visited => visited, :step => acc.step + 1}
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
        move(acc, direction)
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
