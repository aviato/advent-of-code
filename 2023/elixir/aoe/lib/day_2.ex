defmodule DayTwo do
  @moduledoc """

  """

  @doc """
  Returns 1
 
  ## Examples
  iex> DayTwo.main()
  10
  """

  def main(data \\ Input.read_file(2)) do
    split = String.split(data, "\n")
    IO.inspect split
    Enum.reduce(split, 0, fn next, acc ->
      if String.length(next) > 0 do
        validate_game(next) + acc
      else
        acc  
      end
      
    end)
  end

  @doc """
  iex> DayTwo.validate_game("Game 10: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green")
  10
  """

  def validate_game(game_str, max_cubes \\ %{"red" => 12, "green" => 13, "blue" => 14}) do
    game_data = Regex.scan(~r/((\d+) (blue|red|green))/, game_str)
    temp = %{"red" => 0, "green" => 0, "blue" => 0}

    store = Enum.reduce(game_data, temp, fn list, acc ->
      val = Enum.at(list, 2) |> String.to_integer
      color = Enum.at(list, 3)
      if (val > acc[color]) do
        Map.put(acc, color, val)
      else
        acc  
      end
    end)
    
    IO.inspect store
    IO.inspect max_cubes
    IO.puts("Checking validity... #{store["red"] <= max_cubes["red"] && store["green"] <= max_cubes["green"] && store["blue"] <= max_cubes["blue"] }")
    IO.puts "#{store["red"]} * #{store["green"]} * #{store["blue"]} = #{store["red"] * store["green"] * store["blue"]}"

    store["red"] * store["green"] * store["blue"]

  end

end
