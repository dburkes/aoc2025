defmodule Day12 do
  def part1() do
    parse()
    |> count_fits()
  end

  def count_fits(data) do
    Map.get(data, :regions)
    |> Enum.map(fn region ->
      if crudely_fits?(region, Map.get(data, :shapes)), do: 1, else: 0
    end)
    |> Enum.sum()
  end

  def crudely_fits?(region, shapes) do
    shape = Enum.at(shapes, 1)
    area_per_shape = length(shape) * String.length(Enum.at(shape, 0))

    area_needed = Enum.sum(Map.get(region, :counts)) * area_per_shape

    area_available = Map.get(region, :width) * Map.get(region, :height)

    area_available >= area_needed
  end

  def parse(input \\ File.read!("lib/fixtures/day12.txt")) do
    input
    |> String.split("\n\n", trim: true)
    |> Enum.chunk_while(
      [],
      fn line, acc ->
        case line do
          "" ->
            {:cont, acc, []}

          _ ->
            {:cont, [line | acc]}
        end
      end,
      &{:cont, &1, []}
    )
    |> List.flatten()
    |> Enum.reverse()
    |> Enum.reduce(%{:shapes => [], :regions => []}, fn chunk, acc ->
      case chunk =~ ": " do
        true ->
          String.split(chunk, "\n", trim: true)
          |> Enum.reduce(acc, fn
            line, inner_acc ->
              fields = Regex.run(~r/(\d+)x(\d+): (.+)$/, line)

              width = Enum.at(fields, 1)
              height = Enum.at(fields, 2)

              counts =
                Enum.at(fields, 3)
                |> String.split()
                |> Enum.map(&String.to_integer/1)

              region = %{
                :width => String.to_integer(width),
                :height => String.to_integer(height),
                :counts => counts
              }

              Map.merge(inner_acc, %{:regions => [region | Map.get(inner_acc, :regions)]})
          end)
          |> then(fn inner_acc -> Map.merge(acc, inner_acc) end)

        false ->
          String.split(chunk, "\n", trim: true)
          |> Enum.slice(1..-1//1)
          |> then(fn shape_data ->
            Map.merge(acc, %{:shapes => [shape_data | Map.get(acc, :shapes)]})
          end)
      end
    end)
    |> then(fn data ->
      %{
        :shapes => Enum.reverse(Map.get(data, :shapes)),
        :regions => Enum.reverse(Map.get(data, :regions))
      }
    end)
  end
end
