defmodule Day03Part1 do
  def sample do
    content = File.read!("data/day_03/sample.txt")
    doit(content)
  end

  def puzzle do
    content = File.read!("data/day_03/puzzle.txt")
    doit(content)
  end

  def priority(num) do
    # Lowercase item types a through z have priorities 1 through 26.
    # Uppercase item types A through Z have priorities 27 through 52.

    case num do
      c when c in ?a..?z -> c - ?a + 1
      c when c in ?A..?Z -> c - ?A + 27
      _ -> 0
    end
  end

  @spec compart(binary) :: any
  def compart(load) do
    len = String.length(load)
    first = String.slice(load, 0, div(len, 2))
    second = String.slice(load, div(len, 2), len)
    %{:first => first, :second => second}
  end

  def find_overlapping(first_str, second_str) do
    first = String.to_charlist(first_str)
    second = String.to_charlist(second_str)

    try do
      for x <- first do
        if Enum.member?(second, x), do: throw(x)
      end
    catch
      x -> {:ok, x}
    else
      _ -> :error
    end
  end

  def doit(content) do
    String.split(content, "\n")
    |> Enum.map(&compart/1)
    |> Enum.map(&find_overlapping(&1.first, &1.second))
    |> Enum.map(fn x ->
      case x do
        {:ok, v} -> v
        :error -> 0
      end
    end)
    |> Enum.map(&priority/1)
    |> Enum.sum()
  end
end
