defmodule Day07Part1 do
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

    # shape of accumulator
    #  %{
    #    :dirs => array of directory in the form ["/", "dir1", "dir2"]
    #    :wd => array of subpaths (e.g. ["/", "dir1", "dir2"] ),
    #    :files => array of file specs, i.e. [
    #      %{:path => ["/", "dir1", "dir2", "a.txt"], :size: 123}
    #      %{:path => ["/", "dir1", "dir2", "b.txt"], :size: 456}
    #    ]
    #  }
    initial_acc = %{:wd => [], :files => [], :dirs => MapSet.new()}

    %{dirs: dirs, files: files} = Enum.reduce(commands, initial_acc, &process_command/2)

    Enum.map(dirs, fn dir_path -> filter_related_files(dir_path, files) end)
    |> Enum.map(fn files -> Enum.reduce(files, 0, fn file, acc -> acc + file.size end) end)
    |> Enum.filter(fn size -> size <= 100_000 end)
    |> Enum.sum

  end

  def filter_related_files(dir_path, all_files ) do
    Enum.filter(all_files, fn file -> file.path |> Enum.slice(0, length(dir_path)) == dir_path end)
  end



  def process_command("$ ls", acc), do: acc
  def process_command("dir " <> _, acc), do: acc

  def process_command("$ cd ..", acc) do
    %{acc | :wd => List.delete_at(acc.wd, -1)}
  end

  def process_command("$ cd " <> dir, acc) do
    new_path = acc.wd ++ [dir]
    %{acc | :wd => new_path, :dirs => acc.dirs |> MapSet.put(new_path)}
  end

  # it's a file
  def process_command(elem, acc) do
    case Integer.parse(elem) do
      {size, filename} ->
        %{
          acc
          | :files => acc.files ++ [%{:path => acc.wd ++ [String.trim(filename)], :size => size}]
        }

      :error ->
        acc
    end
  end

end
