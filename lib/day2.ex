defmodule Day2 do
  require Integer

  def part1 do
    parse_ranges()
    |> Enum.map(fn range ->
      find_invalid_ids_in_range(range, false)
    end)
    |> List.flatten()
    |> Enum.sum()
  end

  def part2 do
    parse_ranges()
    |> Enum.map(fn range ->
      find_invalid_ids_in_range(range, true)
    end)
    |> List.flatten()
    |> Enum.sum()
  end

  def find_invalid_ids_in_range(range, multiple_repeats) do
    Enum.filter(range, fn id ->
      invalid_id?(Integer.digits(id), multiple_repeats)
    end)
  end

  def invalid_id?(digits, multiple_repeats \\ false) do
    invalid?(digits, multiple_repeats)
  end

  def invalid?(digits, _) when length(digits) == 1 do
    false
  end

  def invalid?(digits, false) when Integer.is_odd(length(digits)) do
    false
  end

  def invalid?(digits, false) when Integer.is_even(length(digits)) do
    Enum.take(digits, div(length(digits), 2)) == Enum.take(digits, -div(length(digits), 2))
  end

  def invalid?(digits, true) do
    1..div(length(digits), 2)
    |> Enum.any?(fn size ->
      Enum.chunk_every(digits, size)
      |> repeating_list?()
    end)
  end

  def repeating_list?([_a]), do: true
  def repeating_list?([a, b | _r]) when a != b, do: false
  def repeating_list?([_a, b | r]), do: repeating_list?([b | r])

  defp parse_ranges do
    File.read!("lib/fixtures/day2.txt")
    |> String.split(",")
    |> Enum.map(fn range ->
      [start_str, end_str] = String.split(range, "-")
      String.to_integer(start_str)..String.to_integer(end_str)
    end)
  end
end
