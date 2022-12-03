defmodule Day02Part2 do

  # Opponent: A for Rock, B for Paper, and C for Scissors
  #       Me: X means you need to lose, Y means you need to end the round in a draw, and Z means you need to win
  # Points: 1 for Rock, 2 for Paper, and 3 for Scissors
  # Points: 0 if you lost, 3 if the round was a draw, and 6 if you won

  def sample do
    content = File.read!("data/day_02/sample.txt")
    doit(content)
  end

  def puzzle do
    content = File.read!("data/day_02/puzzle.txt")
    doit(content)
  end

  @points_for_hand %{:rock => 1, :paper => 2, :scissor => 3 }
  @points_for_result %{:loss => 0, :draw => 3, :win => 6 }

  defp round(element, acc) do
    this_round = case element do
      "A X" -> @points_for_hand[:scissor] + @points_for_result[:loss]
      "A Y" -> @points_for_hand[:rock] + @points_for_result[:draw]
      "A Z" -> @points_for_hand[:paper] + @points_for_result[:win]
      "B X" -> @points_for_hand[:rock] + @points_for_result[:loss]
      "B Y" -> @points_for_hand[:paper] + @points_for_result[:draw]
      "B Z" -> @points_for_hand[:scissor] + @points_for_result[:win]
      "C X" -> @points_for_hand[:paper] + @points_for_result[:loss]
      "C Y" -> @points_for_hand[:scissor] + @points_for_result[:draw]
      "C Z" -> @points_for_hand[:rock] + @points_for_result[:win]
      _ -> 0 # e.g empty lines
    end
    acc + this_round
  end

  def doit (content) do
    String.split(content, "\n")
    |> Enum.reduce(0, &round(&1, &2))
  end
end
