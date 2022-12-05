defmodule Day03Part2 do
  def sample do
    content = File.read!("data/day_03/sample.txt")
    doit(content)
  end

  def puzzle do
    content = File.read!("data/day_03/puzzle.txt")
    doit(content)
  end

  def find_overlapping(first, second, third) do
    first_second =
      for x <- String.graphemes(first), Enum.member?(String.graphemes(second), x) do
        x
      end

    candidates = Enum.uniq(first_second)

    badge =
      for x <- String.graphemes(third), Enum.member?(candidates, x) do
        x
      end

    Enum.at(Enum.uniq(badge), 0)
  end

  def find_priority(rucksack) do
    <<badge::utf8>> =
      find_overlapping(
        hd(rucksack),
        hd(tl(rucksack)),
        hd(tl(tl(rucksack)))
      )

    Day03Part1.priority(badge)
  end

  def build_acc(0, element, _rucksack, priority) do
    %{
      :counter => 1,
      :rucksack => [element],
      :priority => priority
    }
  end

  def build_acc(1, element, rucksack, priority) do
    %{
      :counter => 2,
      :rucksack => [element | rucksack],
      :priority => priority
    }
  end

  def build_acc(2, element, rucksack, priority) do
    %{
      :counter => 0,
      :rucksack => [],
      :priority => priority + find_priority([element | rucksack])
    }
  end

  def split_rucksacks(element, acc) do
    build_acc(acc.counter, element, acc.rucksack, acc.priority)
  end

  def inspect_rucksacks(lines) do
    lines
    |> Enum.reduce(
      %{:counter => 0, :rucksack => [], :priority => 0},
      fn element, acc ->
        split_rucksacks(element, acc)
      end
    )
  end

  def doit(content) do
    lines = String.split(content, "\n")

    r = inspect_rucksacks(lines)
    r.priority
  end
end
