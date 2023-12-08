defmodule DayThreeTest do
  use ExUnit.Case
  doctest DayThree

  test "small matrix sum 1" do
    data = """
    ...317..
    ...*....
    269.....
    """

    assert DayThree.main(data) == 596
  end


end
