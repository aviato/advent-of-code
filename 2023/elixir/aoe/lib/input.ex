defmodule Input do
  @data_dir_path Path.expand("~/repos/advent-of-code/2023/data")

  def read_file(day_num) do
    file_path = Path.join(@data_dir_path, "/day_#{day_num}.txt")
    IO.puts "Attempting to read #{file_path}..."
    File.read!(file_path)
  end
end
