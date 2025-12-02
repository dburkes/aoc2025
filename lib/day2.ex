defmodule Day2 do
  require Integer

  def part1 do
    parse_ranges()
    |> Enum.map(&find_invalid_ids_in_range/1)
    |> List.flatten()
    |> Enum.sum()
  end

  def find_invalid_ids_in_range(range) do
    Enum.filter(range, fn id ->
      invalid_id?(Integer.digits(id))
    end)
  end

  def invalid_id?(digits) when Integer.is_odd(length(digits)) do
    false
  end

  def invalid_id?(digits) when Integer.is_even(length(digits)) do
    Enum.take(digits, div(length(digits), 2)) == Enum.take(digits, -div(length(digits), 2))
  end

  defp parse_ranges do
    File.read!("lib/fixtures/day2.txt")
    |> String.split(",")
    |> Enum.map(fn range ->
      [start_str, end_str] = String.split(range, "-")
      String.to_integer(start_str)..String.to_integer(end_str)
    end)
  end
end
