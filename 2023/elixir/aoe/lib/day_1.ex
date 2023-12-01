defmodule DayOne do
  @moduledoc """
  The newly-improved calibration document consists of lines of text;
  each line originally contained a specific calibration value that the Elves
  now need to recover.

  On each line, the calibration value can be found by combining the first digit
  and the last digit (in that order) to form a single two-digit number.

  For example:

  1abc2
  pqr3stu8vwx
  a1b2c3d4e5f
  treb7uchet

  In this example, the calibration values of these four lines are 12, 38, 15,
  and 77.

  Adding these together produces 142.

  Consider your entire calibration document.
  What is the sum of all of the calibration values?
  """

  @doc """
  Returns the sum of all calibration values specified in (data) day_1.txt

  ## Examples

    iex> DayOne.main()
    142
  """


  @digit_map %{"one" => 1, "two" => 2, "three" => 3, "four" => 4, "five" => 5, "six" => 6, "seven" => 7, "eight" => 8, "nine" => 9}

  def main(data \\ Input.read_file(1)) do
    digit_pattern = ~r/\d|one|two|three|four|five|six|seven|eight|nine/

    Enum.reduce(String.split(data), 0, fn str, acc ->
      results = Regex.scan(digit_pattern, str)
      first_digit = hd(results) |> Enum.at(0) |> digit_to_str
      last_digit = List.last(results) |> Enum.at(0) |> digit_to_str
      IO.puts str
      IO.puts first_digit
      IO.puts last_digit
      IO.puts first_digit <> last_digit
      IO.puts acc
      String.to_integer(first_digit <> last_digit) + acc
    end)
  end

  def digit_to_str(match) do
    val = @digit_map[to_string(match)]

    case val do
      nil -> match
      _ -> to_string(val)
    end
  end
end
