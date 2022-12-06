defmodule Day05Part1 do
  def sample do
    content = File.read!("data/day_05/sample.txt")
    doit(content)
  end

  def puzzle do
    content = File.read!("data/day_05/puzzle.txt")
    doit(content)
  end

  def find_num_crates(lines) do
    lines
    |> Enum.reverse()
    |> Enum.at(0)
    |> String.trim()
    |> (fn s -> Regex.run(~r/\d\d*$/, s) end).()
    |> Enum.at(0)
    |> Integer.parse()
    |> elem(0)
  end

  def transpose_crates(lines) do
    Enum.map(lines, &String.to_charlist/1)
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&List.to_string/1)
    |> Enum.filter(fn x -> Regex.match?(~r/\d\d*$/, x) end)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.reverse/1)
    |> Enum.map(&String.slice(&1, 1..String.length(&1)-1))
  end

  def split_instructions(lines) do
    idx = Enum.find_index(lines, fn x -> x == "" end)
    crates = Enum.take(lines, idx)
    instructions = Enum.take(lines, -1 * (Enum.count(lines) - idx - 1))

    %{
      :crates => crates,
      :instructions => instructions
    }
  end

  def process_single_instruction("") do
    %{"from" => "1", "number" => "0", "to" => "1"} # NO OP
  end

  def process_single_instruction(instruction) do
    Regex.named_captures(~r/move (?<number>\d*) from (?<from>\d*) to (?<to>\d*)/, instruction)
  end



  def move(crates, number, from, to) do
    to_crate = Enum.at(crates, to - 1)
    from_crate = Enum.at(crates, from - 1)
    for i <- 0..length(crates) - 1
    do
      current_crate = Enum.at(crates, i)
      cond do
        i == (from - 1) ->
          String.slice(from_crate, 0, String.length(from_crate) - number)

        i == (to - 1) ->
          to_crate <> String.slice(String.reverse(from_crate), 0, number)

        true ->
          current_crate
      end
    end
  end


  def process_instructions(instructions) do
    instructions
    |> Enum.map(&process_single_instruction/1)

  end

  def doit(content) do
    lines = String.split(content, "\n")
    %{:crates => c, :instructions => i} = split_instructions(lines)

    crates = transpose_crates(c)
    instructions = process_instructions(i)

    Enum.reduce(instructions, crates, fn element, acc ->
      move(
        acc,
        elem(Integer.parse(element["number"]), 0),
        elem(Integer.parse(element["from"]), 0),
        elem(Integer.parse(element["to"]), 0)
        )
    end)
    |> Enum.map(fn s -> String.last(s) end)
    |> Enum.reduce("", fn el, acc -> acc <> el  end)

  end
end
