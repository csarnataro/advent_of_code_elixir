defmodule Day08Part1 do

    # NOTES about optimizations
    #
    # It took 4.48619 seconds to get the result, with the initial naive approach
    # How long will it take with multiprocess and other optimizations?
    #
    # step 1: with
    #         - for comprehension
    #         - skipping double matrix transposition for each element
    #         - filter results and counting them instead of adding them to the full matrix and then reducing it
    # It took 0.204323 seconds to get the result (~20x faster)
    #
    # step 2: adding multiprocess
    #
    #

  def sample do
    content = File.read!("data/day_08/sample.txt")
    doit(content)
  end

  def puzzle do
    content = File.read!("data/day_08/puzzle.txt")
    {uSecs, result} = :timer.tc(Day08Part1, :doit, [content])
    IO.puts("It took #{uSecs / 1_000_000} seconds to get the result")
    result
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

  # def async_protection_level(grid, x, y) do
  #   # IO.puts("******** BEGIN: day_08_part_1:32 ********")
  #   pid = spawn(fn -> protection_level(grid, x, y) end)
  #   # IO.inspect(pid)
  #   # IO.puts("********   END: day_08_part_1:32 ********")
  #   pid
  # end

  def doit(input) do
    grid =
      String.split(input, "\n")
      |> Enum.map(&String.graphemes/1)
      |> Enum.map(&Enum.map(&1, fn v -> String.to_integer(v) end))

    transposed = transpose_matrix(grid)

    num_elems = length(grid) * length(List.first(grid))

    for {row, y} <- Enum.with_index(grid),
        {_elem, x} <- Enum.with_index(row), reduce: 0 do
          acc -> if protection_level(grid, transposed, x, y) == 4, do: acc + 1, else: acc # "#{x} x #{y}" # ==
    end
    |> (&Kernel.-(num_elems, &1)).()
  end

  def protection_level(grid, transposed_grid, x, y) do
    if x == 0 || x == length(List.first(grid)) - 1 || y == 0 || y == length(grid) - 1 do
      0
    else
      is_protected(grid, x, y, :left) +
        is_protected(grid, x, y, :right) +
        is_protected(transposed_grid, x, y, :bottom) + # <=== use the transposed grid here
        is_protected(transposed_grid, x, y, :top)      # <=== and here
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
    is_protected(grid, y, x, :left) # uses the transposed grid
  end

  def is_protected(grid, x, y, :bottom) do
    is_protected(grid, y, x, :right) # uses the transposed grid
  end
end
