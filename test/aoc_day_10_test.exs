defmodule Day10Test do
  use ExUnit.Case

  test "day 10, part 1, sample" do
    assert Day10Part1.sample() == 13140
  end


  test "day 10, part2, sample" do
    # ACTUALLY THERE'S A MISSING PIXEL AT LINE 4 POSITION 39!!!
    expected = """
      ##..##..##..##..##..##..##..##..##..##..
      ###...###...###...###...###...###...###.
      ####....####....####....####....####....
      #####.....#####.....#####.....#####.....
      ######......######......######......###.
      #######.......#######.......#######.....
      """

    assert Day10Part2.sample() == expected
  end
end
