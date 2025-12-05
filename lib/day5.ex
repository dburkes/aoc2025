defmodule Day5 do
  def part1 do
    {ranges, ingredients} = parse_input()

    Enum.count(ingredients, fn ingredient ->
      Enum.any?(ranges, fn range ->
        ingredient in range
      end)
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
          { [Range.new(String.to_integer(start_str), String.to_integer(end_str)) | ranges], ingredients }

          true ->
            { ranges, [String.to_integer(line) | ingredients] }
        end
      end)
    end
end
