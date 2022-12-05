defmodule Day02Test do
  use ExUnit.Case

  @tag :noskip
  test "day 2, part 1 with sample data" do
    assert Day02Part1.sample() == 15
  end

  @tag :noskip
  test "day 2, part 2 with sample data" do
    assert Day02Part2.sample() == 12
  end
end
