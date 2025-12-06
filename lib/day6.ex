defmodule Day6 do
  def part1, do: run(&parse_conventional/0)
  def part2, do: run(&parse_rtl/0)

  def run(parser) do
    {numbers, operators} = parser.()

    operators
    |> Enum.with_index()
    |> Enum.reduce([], fn {op, index}, acc ->
      [calculate(Enum.at(numbers, index), op) | acc]
    end)
    |> Enum.sum()
  end

  def calculate(nums, operator) when operator == "+", do: Enum.sum(nums)
  def calculate(nums, operator) when operator == "*", do: Enum.product(nums)

  defp parse_raw(stream) do
    {numbers, operators} =
      Enum.reduce(stream, {[], []}, fn line, {numbers, operators} ->
        line = String.trim(line)

        cond do
          String.contains?(line, "+") ->
            {numbers, line}

          true ->
            {[line | numbers], operators}
        end
      end)

    {Enum.reverse(numbers), operators}
  end

  def parse_conventional(stream \\ File.stream!("lib/fixtures/day6.txt")) do
    {raw_numbers, raw_operators} = parse_raw(stream)

    numbers =
      Enum.reduce(raw_numbers, [], fn line, acc -> [String.split(line, ~r/\s+/) | acc] end)
      |> Enum.reverse()
      |> Enum.map(fn line -> Enum.map(line, &String.to_integer/1) end)
      |> Enum.zip()
      |> Enum.map(&Tuple.to_list/1)

    {numbers, String.split(raw_operators, ~r/\s+/)}
  end

  def parse_rtl(stream \\ File.stream!("lib/fixtures/day6.txt")) do
    {raw_numbers, raw_operators} = parse_raw(stream)

    ops_with_widths =
      String.split(raw_operators, ~r/([\+\*]\s+)/, include_captures: true, trim: true)

    ops = Enum.map(ops_with_widths, &String.trim/1)

    column_widths = Enum.map(ops_with_widths, fn s -> String.length(s) - 1 end)
    max_width = Enum.max_by(raw_numbers, &String.length/1) |> String.length()

    numbers =
      column_widths
      |> Enum.reduce({[], 0}, fn col_width, {numbers, col_start} ->
        col_end =
          if col_width == 0,
            do: max_width - 1,
            else: col_start + col_width - 1

        nums =
          Enum.reduce(col_start..col_end, [], fn col, acc ->
            columnar_numbers =
              Enum.reduce(raw_numbers, [], fn line, acc ->
                [String.at(line, col) | acc]
              end)
              |> Enum.reverse()
              |> Enum.join()
              |> String.trim()
              |> String.to_integer()

            [columnar_numbers | acc]
          end)

        {[nums | numbers], col_start + col_width + 1}
      end)
      |> elem(0)
      |> Enum.reverse()

    {numbers, ops}
  end
end
