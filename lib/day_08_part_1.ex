defmodule Day08Part1 do
  def sample do
    content = File.read!("data/day_08/sample.txt")
    doit(content)
  end

  def puzzle do
    content = File.read!("data/day_08/puzzle.txt")
    doit(content)
  end

  def get(grid, x, y) do
    grid
    |> Enum.at(y)
    |> Enum.at(x)
  end

  def get(grid, y) do
    grid
    |> Enum.at(y)
  end

  def transpose_matrix(m) do
    Enum.zip_with(m, & &1)
  end

  def doit(input) do
    grid =
      String.split(input, "\n")
      |> Enum.map(fn line -> String.graphemes(line) end)
      |> Enum.map(&Enum.map(&1, fn v -> String.to_integer(v) end))

    num_rows = length(grid)
    num_cols = length(List.first(grid))

    protection_levels =
      grid
      |> Enum.with_index()
      |> Enum.map(fn {row, y} ->
        row
        |> (&Range.new(0, length(&1) - 1)).()
        |> Enum.map(fn x -> protection_level(grid, x, y) end)
      end)

    num_rows * num_cols -
      Enum.reduce(protection_levels, 0, fn row, acc ->
        acc +
          (row
           |> Enum.filter(fn v -> v == 4 end)
           |> Enum.count())
      end)
  end

  def protection_level(grid, x, y) do
    if x == 0 || x == length(List.first(grid)) - 1 || y == 0 || y == length(grid) - 1 do
      0
    else
      is_protected(grid, x, y, :left) +
        is_protected(grid, x, y, :right) +
        is_protected(grid, x, y, :bottom) +
        is_protected(grid, x, y, :top)
    end
  end

  def is_protected_by(protection, elem) do
    cond do
      protection >= elem -> 1
      true -> 0
    end
  end

  def is_protected(grid, x, y, :left) do
    row = get(grid, y)
    elem = get(grid, x, y)

    # protection =
    row
    |> Enum.slice(x + 1, length(row))
    |> Enum.sort(:desc)
    |> hd
    |> is_protected_by(elem)
  end

  def is_protected(grid, x, y, :right) do
    row = get(grid, y)
    elem = get(grid, x, y)

    row
    |> Enum.slice(0, x)
    |> Enum.sort(:desc)
    |> hd
    |> is_protected_by(elem)
  end

  def is_protected(grid, x, y, :top) do
    is_protected(transpose_matrix(grid), y, x, :left)
  end

  def is_protected(grid, x, y, :bottom) do
    is_protected(transpose_matrix(grid), y, x, :right)
  end
end
