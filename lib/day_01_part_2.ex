defmodule Day01Part2 do

  def sample do
    content = File.read!("data/day_01/sample.txt")
    doit(content)
  end

  def puzzle do
    content = File.read!("data/day_01/puzzle.txt")
    doit(content)
  end

  defp reducer(element, acc) do
    case element do
      0 -> %{:cal => [acc.bucket | acc.cal], :bucket => 0}
      _ -> %{:cal => acc.cal, :bucket => acc.bucket + element}
    end
  end

  defp get_value({value, _ }), do: value
  defp get_value(:error), do: 0

  def doit (content) do
    String.split(content, "\n")
      |> Enum.map(&Integer.parse/1)
      |> Enum.map(&get_value/1)
      |> Enum.reduce(%{:cal => [], :bucket => 0}, &reducer(&1, &2))
      |> Map.fetch(:cal)
      |> case do {:ok, v} -> v;  _ -> [] end
      |> Enum.sort()
      # |> tap(&IO.inspect(&1))
      |> Enum.take(-3)
      |> Enum.sum()
  end
end
