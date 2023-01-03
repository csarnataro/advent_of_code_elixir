defmodule Day06Test do
  use ExUnit.Case

  @tag :no_skip
  test "day 6, part 1, sample 1" do
    assert Day06Part1.find_marker('mjqjpqmgbljsphdztnvjfqwrcgsmlb') == 7
  end

  @tag :no_skip
  test "day 6, part 1, sample 2" do
    assert Day06Part1.find_marker('bvwbjplbgvbhsrlpgdmjqwftvncz') == 5
  end

  @tag :no_skip
  test "day 6, part 1, sample 3" do
    assert Day06Part1.find_marker('nppdvjthqldpwncqszvftbrmjlhg') == 6
  end

  @tag :no_skip
  test "day 6, part 1, sample 4" do
    assert Day06Part1.find_marker('nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg') == 10
  end

  @tag :no_skip
  test "day 6, part 1, sample 5" do
    assert Day06Part1.find_marker('zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw') == 11
  end

  # ====
  @tag :nskip
  test "day 6, part 2, sample 1" do
    # gbljsphdztnv
    assert Day06Part2.find_marker('mjqjpqmgbljsphdztnvjfqwrcgsmlb') == 19
  end

  @tag :nskip
  test "day 6, part 2, sample 2" do
    assert Day06Part2.find_marker('bvwbjplbgvbhsrlpgdmjqwftvncz') == 23
  end

  @tag :nskip
  test "day 6, part 2, sample 3" do
    assert Day06Part2.find_marker('nppdvjthqldpwncqszvftbrmjlhg') == 23
  end

  @tag :nskip
  test "day 6, part 2, sample 4" do
    assert Day06Part2.find_marker('nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg') == 29
  end

  @tag :nskip
  test "day 6, part 2, sample 5" do
    assert Day06Part2.find_marker('zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw') == 26
  end
end
