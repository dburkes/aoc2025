defmodule Day6 do
  def part1, do: run(&parse_conventional/0)
  def part2, do: run(&parse_rtl/0)

  def run(parser) do
    parser.() |> calculate()
  end

  def parse_conventional(input \\ File.read!("lib/fixtures/day6.txt")) do
    {lines, operators} = parse_raw(input)

    lines
    |> Enum.map(&String.split/1)
    |> Enum.zip_with(fn numbers -> Enum.map(numbers, &String.to_integer/1) end)
    |> Enum.zip(operators)
  end

  def parse_rtl(input \\ File.read!("lib/fixtures/day6.txt")) do
    {lines, operators} = parse_raw(input)

    lines
    |> Enum.map(&String.to_charlist/1)
    |> Enum.zip_with(&(&1 |> List.to_string() |> String.trim()))
    |> Enum.chunk_while(
      [],
      fn
        "", acc -> {:cont, acc, []}
        num, acc -> {:cont, [String.to_integer(num) | acc]}
      end,
      &{:cont, &1, []}
    )
    |> Enum.zip(operators)
  end

  defp parse_raw(input) do
    {lines, [operators]} =
      input
      |> String.trim()
      |> String.split("\n")
      |> Enum.split(-1)

    {lines, operators |> String.split() |> Enum.map(&String.to_atom/1)}
  end

  defp calculate(operations) do
    operations
    |> Enum.sum_by(fn
      {nums, :+} -> Enum.sum(nums)
      {nums, :*} -> Enum.product(nums)
    end)
  end
end
