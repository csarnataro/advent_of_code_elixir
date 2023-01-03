defmodule Day07Test do
  use ExUnit.Case

  @tag :no_skip
  test "day 7, part 1" do
    assert Day07Part1.sample() == 95437
  end

  @tag :no_skip
  test "day 7, part 2" do
    assert Day07Part2.sample() == 24933642
  end
end
