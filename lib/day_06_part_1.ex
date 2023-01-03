defmodule Day06Part1 do
  def puzzle do
    content = File.read!("data/day_06/puzzle.txt")
    doit(String.to_charlist(content))
  end

  @spec valid_marker?(list) :: boolean
  def valid_marker?(marker) do
    length(Enum.uniq(marker)) == 4
  end

  def find_marker(content, n \\ 0) do
    if length(content) < 4 do
      -1
    else
      first_four = Enum.take(content, 4)
      if valid_marker?(first_four) do
        n + 4
      else
        find_marker(tl(content), n + 1)
      end
    end
  end

  def doit(content) do
    find_marker(content, 0)
  end
end
