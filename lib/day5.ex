defmodule Day5 do
  def part1 do
    {ranges, ingredients} = parse_input()

    Enum.count(ingredients, fn ingredient ->
      Enum.any?(ranges, fn range ->
        ingredient in range
      end)
    end)
  end

  def part2 do
    parse_input()
    |> elem(0)
    |> optimize_ranges()
    |> Enum.sum_by(&Range.size/1)
  end

  def optimize_ranges(ranges) do
    ranges
    |> Enum.sort()
    |> Enum.reduce(MapSet.new(), fn range, disjoint_ranges ->
      cond do
        overlapping_range = Enum.find(disjoint_ranges, fn r -> not Range.disjoint?(r, range) end) ->
          merged_range = Range.new(
            min(overlapping_range.first, range.first),
            max(overlapping_range.last, range.last)
          )

          MapSet.delete(disjoint_ranges, overlapping_range) |> MapSet.put(merged_range)

        true ->
          MapSet.put(disjoint_ranges, range)
      end
    end)
  end

  defp parse_input do
    File.stream!("lib/fixtures/day5.txt")
    |> Enum.map(&String.trim/1)
    |> Enum.reduce({[], []}, fn line, {ranges, ingredients} ->
      cond do
        String.length(line) == 0 ->
          {ranges, ingredients}

        String.contains?(line, "-") ->
          [start_str, end_str] = String.split(line, "-")

          {[Range.new(String.to_integer(start_str), String.to_integer(end_str)) | ranges],
           ingredients}

        true ->
          {ranges, [String.to_integer(line) | ingredients]}
      end
    end)
  end
end
