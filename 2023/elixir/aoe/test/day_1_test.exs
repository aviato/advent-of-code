defmodule DayOneTest do
  use ExUnit.Case
  #doctest DayOne

  test "281" do
    test_data = """
    two1nine
    eighttwothree
    abcone2threexyz
    xtwone3four
    4nineeightseven2
    zoneeight234
    7prstsixteen
    """
    assert DayOne.main(test_data) == 281
  end
 
  test "29" do
    test_data = "two1nine"
    assert DayOne.main(test_data) == 29
  end

  test "whole file" do
    assert DayOne.main() == 54489
  end
 
end
