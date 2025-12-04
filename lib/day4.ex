defmodule Day4 do
  def part1 do
    rolls = parse_rolls()
    Enum.count(rolls, &roll_free?(rolls, &1))
  end

  def part2 do
    rolls = parse_rolls()

    cleaned =
      Stream.repeatedly(fn -> [] end)
      |> Enum.reduce_while(rolls, fn _, acc ->
        removable =
          Enum.filter(acc, &roll_free?(acc, &1))
          |> MapSet.new()

        case MapSet.difference(acc, removable) do
          ^acc -> {:halt, acc}
          remaining -> {:cont, remaining}
        end
      end)

    MapSet.size(rolls) - MapSet.size(cleaned)
  end

  defp adjacent_positions({x, y}) do
    for dx <- -1..1, dy <- -1..1, dx != 0 or dy != 0 do
      {x + dx, y + dy}
    end
  end

  def roll_free?(rolls, pos) do
    pos
    |> adjacent_positions()
    |> Enum.count(&MapSet.member?(rolls, &1))
    |> Kernel.<(4)
  end

  def parse_rolls do
    File.stream!("lib/fixtures/day4.txt")
    |> Enum.map(&String.trim/1)
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, row} ->
      line
      |> String.to_charlist()
      |> Enum.with_index()
      |> Enum.filter(&(elem(&1, 0) == ?@))
      |> Enum.map(&{elem(&1, 1), row})
    end)
    |> MapSet.new()
  end
end
