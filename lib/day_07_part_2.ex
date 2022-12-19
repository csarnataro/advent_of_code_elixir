defmodule Day07Part2 do

  @disk_space 70_000_000
  @space_needed 30_000_000
  def sample do
    content = File.read!("data/day_07/sample.txt")
    doit(content)
  end

  def puzzle do
    content = File.read!("data/day_07/puzzle.txt")
    doit(content)
  end


  def doit(input) do
    commands =
      String.split(input, "\n")
      |> Enum.map(&String.trim/1)

    initial_acc = %{:wd => [], :files => [], :dirs => MapSet.new()}

    %{dirs: dirs, files: files} = Enum.reduce(commands, initial_acc, &Day07Part1.process_command/2)

    sizes = Enum.map(dirs, fn dir_path -> Day07Part1.filter_related_files(dir_path, files) end)
    |> Enum.map(fn files -> Enum.reduce(files, 0, fn file, acc -> acc + file.size end) end)

    disk_usage = sizes
    |> Enum.sort(:desc)
    |> Enum.at(0)

    Enum.filter(sizes, fn size -> size > disk_usage - (@disk_space - @space_needed) end)
    |> Enum.sort()
    |> Enum.at(0)
  end
end
