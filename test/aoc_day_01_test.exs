defmodule Day01Test do
  use ExUnit.Case

  @tag :noskip
  test "day 1, part 1 with sample data" do
    assert Day01Part1.sample() == 24000
  end

  @tag :noskip
  test "day 1, part 2 with sample data" do
    assert Day01Part2.sample() == 45000
  end

end
