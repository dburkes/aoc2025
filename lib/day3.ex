defmodule Day3 do
  def part1 do
    process_banks(2)
  end

  def part2 do
    process_banks(12)
  end

  defp process_banks(num_digits) do
    parse_banks()
    |> Enum.sum_by(&maximize_bank(&1, num_digits))
  end

  def maximize_bank(bank, num_digits) do
    digits = Integer.digits(bank)
    to_remove = length(digits) - num_digits
    Enum.reduce(1..to_remove, digits, fn _, acc -> maximize_digit(acc) end)
    |> Integer.undigits()
  end

  def maximize_digit([_]), do: []
  def maximize_digit([a, b | rest]) when a < b, do: [b | rest]
  def maximize_digit([b | rest]), do: [b | maximize_digit(rest)]

  defp parse_banks do
    File.stream!("lib/fixtures/day3.txt")
    |> Enum.map(fn s ->
      String.trim(s)
      |> String.to_integer()
    end)
  end
end
