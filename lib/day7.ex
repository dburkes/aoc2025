defmodule Day7 do
  def part1(input \\ File.read!("lib/fixtures/day7.txt")) do
    parse(input)
    |> cast_conventional()
  end

  def part2(input \\ File.read!("lib/fixtures/day7.txt")) do
    parse(input)
    |> cast_quantum()
  end

  def cast_conventional({start_col, splitters}) do
    Enum.reduce(splitters, {MapSet.new([start_col]), 0}, fn splits, {beams, count} ->
      hits = MapSet.intersection(beams, splits)

      new_beams =
        Enum.reduce(hits, MapSet.new(), fn hit, acc ->
          MapSet.put(acc, hit - 1) |> MapSet.put(hit + 1)
        end)

      beams = beams |> MapSet.difference(hits) |> MapSet.union(new_beams)

      {beams, MapSet.size(hits) + count}
    end)
    |> elem(1)
  end

  def cast_quantum({start_col, splitters}) do
    Enum.reduce(splitters, %{start_col => 1}, fn splits, beams ->
      Enum.reduce(splits, beams, fn s, acc ->
        case Map.pop(acc, s) do
          {nil, map} ->
            map

          {count, map} ->
            Map.merge(
              map,
              %{
                (s + 1) => count,
                (s - 1) => count
              },
              fn _k, a, b -> a + b end
            )
        end
      end)
    end)
    |> Enum.sum_by(&elem(&1, 1))
  end

  def parse(input) do
    [first | rest] = String.split(input)

    start_col =
      first
      |> String.graphemes()
      |> Enum.find_index(&(&1 == "S"))

    splitters =
      Enum.map(rest, fn row ->
        row
        |> String.to_charlist()
        |> Enum.with_index()
        |> Enum.filter(&(elem(&1, 0) == ?^))
        |> MapSet.new(&elem(&1, 1))
      end)

    {start_col, splitters}
  end
end
