defmodule Day7 do
  def part1() do
    {grid, beam} = parse()

    1..(length(grid) - 1)
    |> Enum.reduce({grid, [beam], 0}, fn row_num, {grid, beams, splits} ->
      cast_beams(grid, beams, splits, row_num)
    end)
    |> elem(2)
  end

  def cast_beams(grid, beams, splits, row) do
    next_row = String.to_charlist(Enum.at(grid, row))

    {new_beams, new_splits} =
      beams
      |> Enum.reduce({MapSet.new(), splits}, fn beam_index, {beams, splits} ->
        case Enum.at(next_row, beam_index) do
          ?. ->
            {MapSet.put(beams, beam_index), splits}

          ?^ ->
            {MapSet.put(beams, beam_index - 1) |> MapSet.put(beam_index + 1), splits + 1}
        end
      end)

    new_beams_list =
      MapSet.to_list(new_beams)
      |> Enum.reject(fn n -> n < 0 || n > length(next_row) end)

    {grid, new_beams_list, new_splits}
  end

  def parse(input \\ File.read!("lib/fixtures/day7.txt")) do
    grid = String.split(input, "\n", trim: true)

    {
      grid,
      Enum.at(grid, 0) |> String.graphemes() |> Enum.find_index(&(&1 == "S"))
    }
  end
end
