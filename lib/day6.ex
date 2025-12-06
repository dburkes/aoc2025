defmodule Day6 do
  def part1 do
    {numbers, operators} = parse_input()

    operators
    |> Enum.with_index()
    |> Enum.reduce([], fn {op, index}, acc ->
      [process(Enum.at(numbers, index), op) | acc]
    end)
    |> Enum.sum()
  end

  def process([], operator) when operator == "+", do: 0
  def process([], operator) when operator == "*", do: 1
  def process([n1 | rest], operator) when operator == "+", do: n1 + process(rest, operator)
  def process([n1 | rest], operator) when operator == "*", do: n1 * process(rest, operator)

  def parse_input(stream \\ File.stream!("lib/fixtures/day6.txt")) do
    {numbers, operators} =
      Enum.reduce(stream, {[], []}, fn line, {numbers, operators} ->
        line_elements = line |> String.trim() |> String.split(~r/\s+/)

        cond do
          Enum.find(line_elements, fn x -> x == "+" end) ->
            {numbers, line_elements}

          true ->
            nums = Enum.map(line_elements, fn x -> String.to_integer(x) end)
            {[nums | numbers], operators}
        end
      end)

    columnar_numbers =
      Enum.map(Enum.zip(numbers), fn nums -> Enum.reverse(Tuple.to_list(nums)) end)

    {columnar_numbers, operators}
  end
end
