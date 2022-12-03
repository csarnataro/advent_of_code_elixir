defmodule Day01Test do
  use ExUnit.Case

  @tag :skip
  test "day 1, part 1 with sample data" do
    assert Day01Part1.sample() == 24000
  end

  @tag :skip
  test "day 1, part 2 with sample data" do
    assert Day01Part2.sample() == 45000
  end

  test "day 2, part 1 with sample data" do
    assert Day02Part1.sample() == 15
  end

  test "day 2, part 2 with sample data" do
    assert Day02Part2.sample() == 12
  end

end
