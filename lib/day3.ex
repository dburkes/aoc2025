defmodule Day3 do
  def part1 do
    process_banks(2)
  end

  def part2 do
    process_banks(12)
  end

  defp process_banks(num_digits) do
    parse_banks()
    |> Enum.map(fn bank -> maximize_bank(bank, num_digits) end)
    |> Enum.sum()
  end

  def maximize_bank(bank, num_digits) do
    digits = Integer.digits(bank)

    1..num_digits
    |> Enum.reduce({[], Enum.slice(digits, 0..-num_digits//1), 0},
        fn digit_num, {selected_digits, remaining_digits, offset_of_remainder} ->
          max_remaining_digit = Enum.max(remaining_digits)
          index_of_max_remaining_digit = Enum.find_index(remaining_digits, fn d -> d == max_remaining_digit end)
          new_start = index_of_max_remaining_digit + offset_of_remainder + 1
          new_end = -(num_digits - digit_num)
          new_offset_of_remainder = new_start
          {[max_remaining_digit | selected_digits], Enum.slice(digits, new_start..new_end//1), new_offset_of_remainder}
        end)
    |> elem(0)
    |> Enum.reverse()
    |> Integer.undigits()
  end

  defp parse_banks do
    File.stream!("lib/fixtures/day3.txt")
    |> Enum.map(fn s ->
      String.trim(s)
      |> String.to_integer()
    end)
  end
end
