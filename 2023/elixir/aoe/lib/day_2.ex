defmodule DayTwo do
  @moduledoc """

  """

  def sum_powers(data \\ Input.read_file(2)) do
    split = String.split(data, "\n")

    Enum.reduce(split, 0, fn next, acc ->
      if String.length(next) > 0 do
         power = generate_game(next) |> calc_power
         acc + power
      else
        acc  
      end

    end)
  end


  def sum_valid_game_ids(data \\ Input.read_file(2)) do
    split = String.split(data, "\n")

    Enum.reduce(split, 0, fn next, acc ->
      if String.length(next) > 0 do
         id = Regex.run(~r/\d+/, next) |> Enum.at(0) |> String.to_integer()
         game = generate_game(next)
         validate_game(id, game) + acc
      else
        acc  
      end

    end)
  end

  @doc """
    iex> DayTwo.validate_game(10, %{"red" => 1, "blue" => 1, "green" => 1})
    10
  """
  def validate_game(id, outcome, max_cubes \\ %{"red" => 12, "green" => 13, "blue" => 14}) do
    if outcome["red"] <= max_cubes["red"] && outcome["green"] <= max_cubes["green"] && outcome["blue"] <= max_cubes["blue"] do
      id
    else  
      0
    end
  end

  @doc """
    iex> DayTwo.generate_game("Game 10: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green")
    %{"red" => 4, "blue" => 6, "green" => 2}
  """
  def generate_game(game_str) do
    game_data = Regex.scan(~r/((\d+) (blue|red|green))/, game_str)
    temp = %{"red" => 0, "green" => 0, "blue" => 0}

    Enum.reduce(game_data, temp, fn next_round, acc ->
      val = Enum.at(next_round, 2) |> String.to_integer
      color = Enum.at(next_round, 3)

      if (val > acc[color]) do
        Map.put(acc, color, val)
      else
        acc
      end

    end)
  end


  @doc """
    iex> DayTwo.calc_power(%{"red" => 4, "blue" => 6, "green" => 2})
    48
  """
  def calc_power(outcome) do
    outcome["red"] * outcome["blue"] * outcome["green"]
  end
end
