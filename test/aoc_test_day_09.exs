defmodule Day09Test do
  use ExUnit.Case

  @tag :skip
  test "day 9, part 2, sample 1" do
    assert Day09Part2.sample() == 0
  end

  @tag :skip
  test "day 9, part 2, sample 2" do
    assert Day09Part2.sample_2() == 36
  end

  @tag :skip
  test "day 9, part 1" do
    assert Day09Part1.sample() == 13
  end

  @tag :skip
  test "day 9, part 1, expand single line input" do
    input = "R 4"
    assert Day09Part1.expand(input) == [:r, :r, :r, :r]
  end

  @tag :skip
  test "day 9, part 1, expand multiple lines input" do
    input =
      """
      R 4
      U 4
      L 3
      """
    assert Day09Part1.expand(input) == [
      :r, :r, :r, :r,
      :u, :u, :u, :u,
      :l, :l, :l,
    ]
  end

  @tag :skip
  test "day 9, part 1, diff 2 positions" do
    positions = {{0, 0}, {0, 0}}
    assert Day09Part1.diff_between_points(positions) == {0, 0}
  end

  @tag :skip
  test "day 9, part 1, diff 2 positions (2)" do
    positions = {{0, 0}, {1, 1}}
    assert Day09Part1.diff_between_points(positions) == {1, 1}
  end

  @tag :skip
  test "day 9, part 1, diff 2 positions (3)" do
    positions = {{-1, 1}, {-3, 1}}
    assert Day09Part1.diff_between_points(positions) == {-2, 0}
  end

  @tag :skip
  test "day 9, part 1, move/3 from same position right 1" do
    %{:positions => {{1, 0}, {0, 0}} = positions} = Day09Part1.move(%{:positions => {{0, 0}, {0, 0}}, :visited => MapSet.new()}, :r, {0, 0})
    assert positions== {{1, 0}, {0, 0}}
    # assert Day09Part1.move({{3, 4}, {3, 4}}, :r, {0, 0}) == {{4, 4}, {3, 4}}
  end

  @tag :skip
  test "day 9, part 1, move from a difference of {-1, 0} right 1" do
    assert Day09Part1.move({{1, 0}, {0, 0}}, :r, {-1, 0}) == {{2, 0}, {1, 0}}
    assert Day09Part1.move({{3, 4}, {2, 4}}, :r, {-1, 0}) == {{4, 4}, {3, 4}}
  end

  @tag :skip
  test "day 9, part 1, move from a difference of {0, 1} right 1" do
    assert Day09Part1.move({{1, 0}, {-1, -1}}, :r, {0, 1}) == {{2, 0}, {-1, -1}}
    assert Day09Part1.move({{3, 4}, {3, 3}}, :r, {0, 1}) == {{4, 4}, {3, 3}}
  end

  test "day 9, part 2, sample" do
    assert Day09Part2.sample() == 0
  end
  test "day 9, part 2, sample 2" do
    assert Day09Part2.sample() == 36
  end


  test "day 9, part 2, move 10 knots rope" do
    initial_positions = Tuple.duplicate({0,0}, 10)
    assert Day09Part2.move_10_knots_rope(%{:positions => initial_positions, :visited => nil}, :u) == {
      {0,1},
      {0,0},
      {0,0},
      {0,0},
      {0,0},
      {0,0},
      {0,0},
      {0,0},
      {0,0},
      {0,0}
    }
  end

end
