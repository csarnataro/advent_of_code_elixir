defmodule Day08Test do
  use ExUnit.Case

  @tag :no_skip
  test "day 8, part 1" do
    assert Day08Part1.sample() == 21
  end

  @tag :nskip
  test "day 8, part 2" do
    assert Day08Part2.sample() == 8
  end

  @tag :nskip
  test "day 8, part 2, how_many_visible_trees on the right" do
    grid = [
      [3, 0, 3, 7, 3 ],
      [2, 5, 5, 1, 2 ],
      [6, 5, 3, 3, 2 ],
      [3, 3, 5, 4, 9 ],
      [3, 5, 3, 9, 0 ]
    ]

    expected = [
      [4, 3, 4, 8, 4],
      [3, 4, 6, 4, 4],
      [8, 7, 4, 5, 3],
      [3, 4, 7, 6, 8],
      [2, 5, 3, 8, 2]
    ]

    assert Day08Part2.how_many_visible_trees(grid, 1, 1, :right) == 1

    assert Day08Part2.how_many_visible_trees(grid, 3, 2, :right) == 1

    assert Day08Part2.how_many_visible_trees(grid, 2, 3, :right) == 2
  end

  @tag :nskip
  test "day 8, part 2, how_many_visible_trees on the left" do
    grid = [
      [3, 0, 3, 7, 3 ],
      [2, 5, 5, 1, 2 ],
      [6, 5, 3, 3, 2 ],
      [3, 3, 5, 4, 9 ],
      [3, 5, 3, 9, 0 ]
    ]

    assert Day08Part2.how_many_visible_trees(grid, 1, 1, :left) == 1

    assert Day08Part2.how_many_visible_trees(grid, 3, 2, :left) == 1

    assert Day08Part2.how_many_visible_trees(grid, 2, 3, :left) == 2
  end

  @tag :nskip
  test "day 8, part 2, how_many_visible_trees on the bottom" do
    grid = Day08Part1.transpose_matrix([
      [3, 0, 3, 7, 3 ],
      [2, 5, 5, 1, 2 ],
      [6, 5, 3, 3, 2 ],
      [3, 3, 5, 4, 9 ],
      [3, 5, 3, 9, 0 ]
    ])

    assert Day08Part2.how_many_visible_trees(grid, 1, 1, :bottom) == 1

    assert Day08Part2.how_many_visible_trees(grid, 3, 2, :bottom) == 1

    assert Day08Part2.how_many_visible_trees(grid, 2, 3, :bottom) == 1

    assert Day08Part2.how_many_visible_trees(grid, 4, 0, :bottom) == 3
  end

  test "day 8, part 2, how_many_visible_trees on the top" do
    grid = Day08Part1.transpose_matrix([
      [3, 0, 3, 7, 3 ],
      [2, 5, 5, 1, 2 ],
      [6, 5, 3, 3, 2 ],
      [3, 3, 5, 4, 9 ],
      [3, 5, 3, 9, 0 ]
    ])

    assert Day08Part2.how_many_visible_trees(grid, 1, 1, :top) == 1
    assert Day08Part2.how_many_visible_trees(grid, 3, 2, :top) == 2
    assert Day08Part2.how_many_visible_trees(grid, 2, 3, :top) == 2
    assert Day08Part2.how_many_visible_trees(grid, 4, 3, :top) == 3
  end

end
