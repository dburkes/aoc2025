defmodule Day11 do
  use Memoize

  def part1() do
    parse()
    |> count("you", "out")
  end

  def part2() do
    map = parse()

    dac_fft = count(map, "svr", "dac") * count(map, "dac", "fft") * count(map, "fft", "out")
    fft_dac = count(map, "svr", "fft") * count(map, "fft", "dac") * count(map, "dac", "out")

    dac_fft + fft_dac
  end

  def count(_, to, to), do: 1

  defmemo count(map, from, to) do
    map
    |> Map.get(from, [])
    |> Enum.map(&count(map, &1, to))
    |> Enum.sum()
  end

  def parse(input \\ File.read!("lib/fixtures/day11.txt")) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(%{}, fn line, acc ->
      [name, connections] = String.split(line, ":", trim: true)
      Map.put(acc, name, String.split(connections))
    end)
  end
end
