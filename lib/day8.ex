defmodule Day8 do
  def part1() do
    {circuits, _} =
      parse()
      |> create_circuits(1000)

    circuits
    |> Enum.map(&MapSet.size/1)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.product()
  end

  def part2() do
    {_, last_connection} =
      parse()
      |> create_mega_circuit()

    elem(Enum.at(last_connection, 0), 0) * elem(Enum.at(last_connection, 1), 0)
  end

  def create_circuits(boxes, count) do
    circuits =
      boxes
      |> Enum.map(&MapSet.new([&1]))

    distances(boxes)
    |> Enum.with_index()
    |> Enum.reduce_while({circuits, []}, fn {[box1, box2], index}, {acc, _} ->
      source_circuit = Enum.find(acc, fn circuit -> MapSet.member?(circuit, box2) end)
      destination_circuit = Enum.find(acc, fn circuit -> MapSet.member?(circuit, box1) end)
      updated_circuit = MapSet.union(destination_circuit, source_circuit)

      updated_circuits = [
        updated_circuit | List.delete(acc, source_circuit) |> List.delete(destination_circuit)
      ]

      cond do
        count == nil ->
          {
            if(length(updated_circuits) != 1, do: :cont, else: :halt),
            {updated_circuits, [box1, box2]}
          }

        true ->
          {
            if(index + 1 < count, do: :cont, else: :halt),
            {updated_circuits, [box1, box2]}
          }
      end
    end)
  end

  def create_mega_circuit(boxes), do: create_circuits(boxes, nil)

  def distances(boxes) do
    boxes
    |> Enum.with_index()
    |> Enum.flat_map(fn {box, index} ->
      distances(box, Enum.slice(boxes, (index + 1)..-1//1))
    end)
    |> Enum.sort_by(fn {_, dist} -> dist end)
    |> Enum.map(&MapSet.to_list(elem(&1, 0)))
  end

  def distances(box, other_boxes) do
    Enum.map(other_boxes, fn other_box ->
      {MapSet.new([box, other_box]), distance(box, other_box)}
    end)
  end

  def distance({x1, y1, z1}, {x2, y2, z2}) do
    dx = x1 - x2
    dy = y1 - y2
    dz = z1 - z2
    :math.sqrt(dx * dx + dy * dy + dz * dz)
  end

  def parse(input \\ File.read!("lib/fixtures/day8.txt")) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, ",", trim: true))
    |> Enum.map(&Enum.map(&1, fn j -> String.to_integer(j) end))
    |> Enum.map(&List.to_tuple/1)
  end
end
