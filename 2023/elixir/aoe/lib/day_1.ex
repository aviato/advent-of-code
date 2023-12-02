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
    54473
  """


  @digit_map %{"one" => 1, "two" => 2, "three" => 3, "four" => 4, "five" => 5, "six" => 6, "seven" => 7, "eight" => 8, "nine" => 9}

  def main(data \\ Input.read_file(1)) do
    fw_pattern = ~r/\d|one|two|three|four|five|six|seven|eight|nine/
    bw_pattern = ~r/\d|eno|owt|eerht|ruof|evif|xis|neves|thgie|enin/

    Enum.reduce(String.split(data), 0, fn str, acc ->
      fw_result = Regex.run(fw_pattern, str)
      bw_result = Regex.run(bw_pattern, String.reverse(str))
      first_digit = fw_result |> Enum.at(0) |> digit_to_str
      last_digit_r = bw_result |> Enum.at(0)
      last_digit = digit_to_str(String.reverse(last_digit_r))
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
