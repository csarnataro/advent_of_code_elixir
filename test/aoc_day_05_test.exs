defmodule Day05Test do
  use ExUnit.Case

  @tag :no_skip
  test "day 5, part 1, find num of crates" do
    input = [
      "    [D]    ",
      "[N] [C]    ",
      "[Z] [M] [P]",
      " 1   2   3 "
    ]

    assert Day05Part1.find_num_crates(input) == 3
  end

  @tag :no_skip
  test "day 5, part 1 with sample data" do
    assert Day05Part1.sample() == "CMZ"
  end

  @tag :no_skip
  test "day5, part 1, invert cranes" do
    input = [
      "    [D]    ",
      "[N] [C]    ",
      "[Z] [M] [P]",
      " 1   2   3 "
    ]

    assert Day05Part1.transpose_crates(input) == [
             "ZN",
             "MCD",
             "P"
           ]
  end

  @tag :no_skip
  test "day5, part1, process single instruction" do
    assert Day05Part1.process_single_instruction("move 3 from 1 to 5") == %{
             "number" => "3",
             "from" => "1",
             "to" => "5"
           }
  end

  @tag :no_skip
  test "day5, part1, process multiple instruction" do
    input = [
      "move 1 from 2 to 1",
      "move 3 from 1 to 3",
      "move 2 from 2 to 1",
      "move 1 from 1 to 2"
    ]

    expected = [
      %{"number" => "1", "from" => "2", "to" => "1"},
      %{"number" => "3", "from" => "1", "to" => "3"},
      %{"number" => "2", "from" => "2", "to" => "1"},
      %{"number" => "1", "from" => "1", "to" => "2"}
    ]

    assert Day05Part1.process_instructions(input) == expected
  end

  @tag :no_skip
  test "move 1" do
    number = 1
    from = 2
    to = 1

    crates = [
      "ZN",
      "MCD",
      "P"
    ]

    assert Day05Part1.move(crates, number, from, to) == [
             "ZND",
             "MC",
             "P"
           ]
  end

  @tag :no_skip
  test "move 2" do
    # move 3 from 1 to 3
    number = 3
    from = 1
    to = 3

    crates = [
      "ZND",
      "MC",
      "P"
    ]

    assert Day05Part1.move(crates, number, from, to) == [
             "",
             "MC",
             "PDNZ"
           ]
  end

  @tag :no_skip
  test "move 3" do
    # move 2 from 2 to 1
    number = 2
    from = 2
    to = 1

    crates = [
      "",
      "MC",
      "PDNZ"
    ]

    assert Day05Part1.move(crates, number, from, to) == [
      "CM",
      "",
      "PDNZ"
    ]
  end

  @tag :no_skip
  test "move 5" do
    # move 1 from 1 to 2
    number = 1
    from = 1
    to = 2

    crates = [
      "CM",
      "",
      "PDNZ"
    ]

    assert Day05Part1.move(crates, number, from, to) == [
      "C",
      "M",
      "PDNZ"
    ]
  end


  @tag :nskip
  test "day 5, part 2 with sample data" do
    assert Day05Part2.sample() == "MCD"
  end

end
