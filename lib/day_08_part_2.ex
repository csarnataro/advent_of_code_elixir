defmodule Day08Part2 do
  def sample do
    content = File.read!("data/day_08/sample.txt")
    doit(content)
  end

  def puzzle do
    content = File.read!("data/day_08/puzzle.txt")
    {uSecs, result} = :timer.tc(Day08Part2, :doit, [content])
    IO.puts("It took #{uSecs / 1_000_000} seconds to get the result")
    result
  end

  def doit(input) do
    grid =
      String.split(input, "\n")
      |> Enum.map(fn line -> String.graphemes(line) end)
      |> Enum.map(&Enum.map(&1, fn v -> String.to_integer(v) end))

    transposed_grid = Day08Part1.transpose_matrix(grid)

    visible_trees =
      grid
      |> Enum.with_index()
      |> Enum.map(fn {row, y} ->
        row
        |> (&Range.new(0, length(&1) - 1)).()
        |> Enum.map(fn x -> total_visible_trees(grid, transposed_grid, x, y) end)
      end)

    IO.inspect(visible_trees)

    visible_trees
    |> Enum.map(&Enum.sort(&1, :desc))
    |> Enum.map(&Enum.at(&1, 0))
    |> Enum.max()

  end

  def total_visible_trees(grid, transposed_grid, x, y) do
    how_many_visible_trees(grid, x, y, :left) *
    how_many_visible_trees(grid, x, y, :right) *
    how_many_visible_trees(transposed_grid, x, y, :top) *
    how_many_visible_trees(transposed_grid, x, y, :bottom)
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
    grid
    |> how_many_visible_trees(y, x, :right)
  end

  def how_many_visible_trees(grid, x, y, :top) do
    grid
    |> how_many_visible_trees(y, x, :left)
  end
end
