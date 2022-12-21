defmodule Day08Part2 do
  def sample do
    content = File.read!("data/day_08/sample.txt")
    doit(content)
  end

  def puzzle do
    content = File.read!("data/day_08/puzzle.txt")
    doit(content)
  end

  def doit(input) do
    grid =
      String.split(input, "\n")
      |> Enum.map(fn line -> String.graphemes(line) end)
      |> Enum.map(&Enum.map(&1, fn v -> String.to_integer(v) end))

      visible_trees =
        grid
        |> Enum.with_index()
        |> Enum.map(fn {row, y} ->
          row
          |> (&Range.new(0, length(&1) - 1)).()
          |> Enum.map(fn x -> how_many_visible_trees(grid, x, y) end)
        end)

      visible_trees
      |> Enum.map(&Enum.sort(&1, :desc))
      |> Enum.map(&Enum.at(&1, 0))
      |> Enum.max()

  end

  def how_many_visible_trees(grid, x, y) do
    how_many_visible_trees(grid, x, y, :left) *
    how_many_visible_trees(grid, x, y, :right) *
    how_many_visible_trees(grid, x, y, :top) *
    how_many_visible_trees(grid, x, y, :bottom)
  end

  def how_many_visible_trees(grid, x, y, :right) do
    row = Day08Part1.get(grid, y)
    elem = Day08Part1.get(grid, x, y)

    row
    |> Enum.slice(x + 1, length(row))
    |> Enum.reduce_while(0, fn x, acc ->
      if x < elem, do: {:cont, acc + 1}, else: {:halt, acc + 1}
    end)
  end

  def how_many_visible_trees(grid, x, y, :left) do
    row = Day08Part1.get(grid, y)
    elem = Day08Part1.get(grid, x, y)

    row
    |> Enum.slice(0, x)
    |> Enum.reverse()
    |> Enum.reduce_while(0, fn x, acc ->
        if x < elem, do: {:cont, acc + 1}, else: {:halt, acc + 1}
    end)
  end

  def how_many_visible_trees(grid, x, y, :bottom) do
    Day08Part1.transpose_matrix(grid)
    |> how_many_visible_trees(y, x, :right)
  end

  def how_many_visible_trees(grid, x, y, :top) do
    Day08Part1.transpose_matrix(grid)
    |> how_many_visible_trees(y, x, :left)
  end
end
