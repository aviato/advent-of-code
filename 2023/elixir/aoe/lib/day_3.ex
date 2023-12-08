defmodule DayThree do
  @moduledoc """
    What is the sum of all of the part numbers in the engine schematic?
  """

  def update_char_map(map \\ %{}, char_buffer \\ "", row_index \\ 0, last_char_index)

  def update_char_map(map, char_buffer, row_index, last_char_index) do
    length    = String.length(char_buffer)
    positions = last_char_index-length..last_char_index |> Enum.to_list
    coords    = Enum.map(positions, fn next ->
      {row_index, next}
    end) |> List.to_tuple
    Map.put(map, coords, %{:label => char_buffer, :is_verified => false, :val => String.to_integer(char_buffer)})
  end

  @doc """
    iex> DayThree.main()
    1
  """
  def main(data \\ Input.read_file(3)) do
    split_input = String.split(data, "\n") |> List.to_tuple
    parsed_rows = string_to_char_tuple(split_input)
    result = reduce_tuple(parsed_rows, 0, {}, fn row, i, acc ->
      Tuple.append(acc, filter_map(row, %{}, fn inner_acc, char_buffer, row_i, sub_i -> 
        update_char_map(inner_acc, char_buffer, row_i, sub_i)
      end, i))
    end)

    # IO.inspect result

    special_result = reduce_tuple(split_input, 0, %{}, fn row, i, acc ->
      special_chars_match = Regex.scan(~r/[^a-zA-Z\.0-9\n]/, row, return: :index)
      temp = Enum.map(special_chars_match, fn next ->
        match_tuple = Enum.at(next, 0)
        special_char_index = elem(match_tuple, 0)
        special_char = String.at(row, special_char_index)
        {i, special_char_index}
      end)

      Enum.reduce(temp, %{}, fn next, acc ->
        Map.put(acc, next, String.at(row, elem(next, 1)))
      end)
    end)


    IO.inspect special_result
  end
  
  def string_to_char_tuple(tuple, i \\ 0, acc \\ {})

  def string_to_char_tuple(tuple, i, acc) when i < tuple_size(tuple) do
    row     = elem(tuple, i)
    new_row = String.split(row, "", trim: true) |> List.to_tuple
    new_acc = Tuple.append(acc, new_row)
    string_to_char_tuple(tuple, i + 1, new_acc)
  end

  def string_to_char_tuple(_tuple, _i, acc) do
    acc
  end

  def reduce_tuple(tuple, i \\ 0, acc, callback_fn)

  def reduce_tuple(tuple, i, acc, callback_fn) when i < tuple_size(tuple) do
    ele     = elem(tuple, i)
    IO.inspect ele
    IO.inspect i
    IO.inspect acc
    new_acc = callback_fn.(ele, i, acc)
    reduce_tuple(tuple, i + 1, new_acc, callback_fn)
  end

  def reduce_tuple(_tuple, _i, acc, _callback_fn) do
    acc
  end

  @doc """
    NO IDEA WHAT I'M DOING...
  """
  def filter_map(tuple, acc, callback_fn, row_index \\ 0, next_index \\ 0, char_buffer \\ "")

  def filter_map(tuple, acc, callback_fn, row_index, next_index, char_buffer) when next_index < tuple_size(tuple) do
    char = elem(tuple, next_index)
    match = Regex.run(~r/\d/, char)
    case match do
      nil ->
        new_acc = if String.length(char_buffer) > 0, do: callback_fn.(acc, char_buffer, row_index, next_index), else: acc
        filter_map(tuple, new_acc, callback_fn, row_index, next_index + 1, "")
      _ ->
        buffer_update = char_buffer <> char
        filter_map(tuple, acc, callback_fn, row_index, next_index + 1, buffer_update)
    end
  end

  def filter_map(tuple, acc, callback_fn, row_index, next_index, char_buffer) when next_index == tuple_size(tuple) do
    new_acc = if String.length(char_buffer) > 0, do: callback_fn.(acc, char_buffer, row_index, next_index), else: acc
    filter_map(tuple, new_acc, callback_fn, row_index, next_index + 1, "")
  end

  def filter_map(_tuple, acc, _callback_fn, _row_index, _next_index, _char_buffer) do
    acc
  end

  @doc """
    Searches through input string for all number strings and returns a Map with the 
    shape of the data shown below. The key will be the coordinates of all of a number
    strings chars, and the value is another Map containing the label, value (int) and
    verification status.

    We will use another function to update these values if
    the number string can be verified as a valid part id.

    # Example
    
    # Input:
    # ...317..
    # ...*....
    # 269.....

    # Output:
    # %{
    #    {{0, 3}, {0, 4}, {0, 5}} => %{:label => "123", :value => 123, verified => false },
    #    {{2, 0}, {2, 1}, {2, 2}} => %{:label => "269", :value => 269, verified => false }
    #  }
  """

  def get_unverified_part_ids(row_id, chars) do
    split_chars = String.split(chars, "", trim: true) |> List.to_tuple()
    IO.inspect split_chars
  end

  @doc """
    Returns true if char is a non-digit, non-whitespace, non-period literal symbol

    Example:
      iex> DayThree.is_part_symbol?(".")
      false
      iex> DayThree.is_part_symbol?("42")
      false
      iex> DayThree.is_part_symbol?("A")
      false
      iex> DayThree.is_part_symbol?("*")
      true
  """
  def is_part_symbol?(char) do
    
  end

  def is_digit?(char) do
    match = Regex.run(~r/\d/, char)
    IO.inspect match
  end

  def get_char_classification(char) do
    cond do
      char == "." ->
        :continue
      char == nil ->
        :nil
      is_digit?(char) ->
        :number
      is_part_symbol?(char) ->
        :part_symbol
    end
  end

  def parse_chars() do
    :ok
  end

  def capture_number(str, i, str_buffer, acc) do
    current_char = String.at(str, i)
    char_type    = get_char_classification(current_char)
    concat       = current_char <> str_buffer
    IO.puts current_char
    IO.puts char_type
    IO.puts concat
    case char_type do
      :number ->
        acc_update = %{:label => concat, :val => String.to_integer(concat), :verified => false}
        capture_number(str, i + 1, concat, acc_update)
      :nil ->
        acc
       _ ->
        capture_number(str, i + 1, concat, acc)
    end
  end
end
