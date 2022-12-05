defmodule Day04Part1 do
  def sample do
    content = File.read!("data/day_04/sample.txt")
    doit(content)
  end

  def puzzle do
    content = File.read!("data/day_04/puzzle.txt")
    doit(content)
  end

  def is_subrange?("") do
    false
  end

  def is_subrange?(range_as_str) do
    # 2-4,6-8
    ranges = String.split(range_as_str, ",")
    first = Enum.at(ranges, 0)
    second = Enum.at(ranges, 1)

    first_range_lower = elem(Integer.parse(Enum.at(String.split(first, "-"), 0)), 0)
    first_range_upper = elem(Integer.parse(Enum.at(String.split(first, "-"), 1)), 0)
    first_range = Range.new(first_range_lower, first_range_upper)

    second_range_lower = elem(Integer.parse(Enum.at(String.split(second, "-"), 0)), 0)
    second_range_upper = elem(Integer.parse(Enum.at(String.split(second, "-"), 1)), 0)

    second_range = Range.new(second_range_lower, second_range_upper)

    cond do
      Enum.count(first_range) == Enum.count(second_range) && first_range_lower === second_range_lower -> true

      Enum.count(first_range) > Enum.count(second_range)
        && second_range_lower in first_range
        && second_range_upper in first_range
        -> true

      Enum.count(second_range) > Enum.count(first_range)
        && first_range_lower in second_range
        && first_range_upper in second_range
        -> true

      true -> false
    end
  end

  def get_subrange(element, acc) do
    subrange = case is_subrange?(element) do true -> 1 ; false -> 0 end
    acc + subrange
  end

  def doit(content) do
    String.split(content, "\n")
    |> Enum.reduce(0, &get_subrange(&1, &2))
  end
end
