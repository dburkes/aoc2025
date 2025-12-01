defmodule Day1 do
  def part1 do
    parse_moves()
    |> process_moves()
    |> Enum.count(fn info -> elem(info, 0) == 0 end)
  end

  def part2 do
    parse_moves()
    |> process_moves()
    |> Enum.reduce(0, fn {pos, zeros_crossed}, acc ->
      acc + zeros_crossed + if pos == 0, do: 1, else: 0
    end)
  end

  defp process_moves(moves) do
    Enum.flat_map_reduce(moves, 50, fn {dir, dist_str}, acc ->
      m = process_move(acc, dir, String.to_integer(dist_str))
      {[m], elem(m, 0)}
    end)
    |> elem(0)
  end

  def process_move(start, dir, dist) when dir == "R" do
    sum = start + dist
    new_pos = Integer.mod(sum, 100)

    case new_pos do
      0 ->
        {new_pos, div(sum, 100) - 1}
      _ ->
        {new_pos, div(sum, 100)}
    end
  end

  def process_move(start, dir, dist) when dir == "L" do
    sum = start - dist
    new_pos = Integer.mod(sum, 100)

    case sum do
      n when n >= 0 ->
        {new_pos, 0}

      _ ->
        case new_pos do
          0 ->
            {new_pos, div(abs(sum), 100)}
          _ ->
          {new_pos, div(abs(sum), 100) + (if start != 0, do: 1, else: 0)}
        end
    end
  end

  defp parse_moves do
      File.stream!("lib/fixtures/day1.txt")
      |> Enum.map(fn s ->
        String.trim(s)
        |> String.split_at(1)
      end)
  end
end
