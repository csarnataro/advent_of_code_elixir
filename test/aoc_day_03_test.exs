defmodule Day03Test do
  use ExUnit.Case

  @tag :no_skip
  test "day 3, part 1 with sample data" do
    assert Day03Part1.sample() == 157
  end

  @tag :no_skip
  test "day 3, compart" do
    assert Day03Part1.compart("vJrwpWtwJgWrhcsFMMfFFhFp") == %{
             first: "vJrwpWtwJgWr",
             second: "hcsFMMfFFhFp"
           }
  end

  @tag :no_skip
  test "day 3, priority" do
    assert Day03Part1.priority(?a) == 1
    assert Day03Part1.priority(?b) == 2
    assert Day03Part1.priority(?z) == 26
    assert Day03Part1.priority(?A) == 27
    assert Day03Part1.priority(?B) == 28
    assert Day03Part1.priority(?Z) == 52
  end

  @tag :no_skip
  test "day 3, find overlapping item" do
    assert Day03Part1.find_overlapping("abc", "dce") === {:ok, ?c}
    assert Day03Part1.find_overlapping("abc", "dre") === :error
  end

  @tag :nskip
  test "day 3, part 2 with sample data" do
    assert Day03Part2.sample() == 70
  end

  @tag :no_skip
  test "day3, part 2, find overlapping" do
    assert Day03Part2.find_overlapping(
             "vJrwpWtwJgWrhcsFMMfFFhFp",
             "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL",
             "PmmdzqPrVvPwwTWBwg"
           ) == "r"
  end

  @tag :no_skip
  test "day3, part 2, find overlapping 2" do
    assert Day03Part2.find_overlapping(
             "wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn",
             "ttgJtRGJQctTZtZT",
             "CrZsJsPPZsGzwwsLwLmpwMDw"
           ) == "Z"
  end

  @tag :no_skip
  test "day 3, part 2, build rucksacks" do
    input = [
      "vJrwpWtwJgWrhcsFMMfFFhFp",
      "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL",
      "PmmdzqPrVvPwwTWBwg"
    ]

    assert Day03Part2.inspect_rucksacks(input).priority === 18
  end
end
