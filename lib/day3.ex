defmodule Day3 do
  def part1 do
    parse_banks()
    |> Enum.map(&maximize_bank/1)
    |> Enum.sum()
  end

  def maximize_bank(bank) do
    Enum.reduce(Integer.digits(bank), {nil, nil, nil}, fn this_digit, locked_digits ->
      process_digit(this_digit, locked_digits)
    end)
    |> then(fn {first_digit, second_digit, previous_first_digit} ->
      cond do
        second_digit == nil ->
          [previous_first_digit, first_digit]
        true ->
          [first_digit, second_digit]
      end
    end)
    |> Integer.undigits()
  end

  def process_digit(this_digit, {nil, nil, _}) do
    {this_digit, nil, nil}
  end

  def process_digit(this_digit, {first_digit, nil, _}) do
    cond do
      this_digit > first_digit ->
        {this_digit, nil, first_digit}
      true ->
        {first_digit, this_digit, nil}
    end
  end

  def process_digit(this_digit, {first_digit, second_digit, previous_first_digit}) do
    cond do
      this_digit > first_digit ->
        {this_digit, nil, first_digit}
      this_digit > second_digit ->
        {first_digit, this_digit, nil}
      true ->
        {first_digit, second_digit, previous_first_digit}
    end
  end

  def parse_banks do
    File.stream!("lib/fixtures/day3.txt")
    |> Enum.map(fn s ->
      String.trim(s)
      |> String.to_integer()
    end)
  end
end
