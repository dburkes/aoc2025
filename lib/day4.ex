defmodule Day4 do
  def part1 do
    parse_rolls()
    |> count_accessible_rolls()
  end

  def count_accessible_rolls(grid) do
    rows = length(grid)
    cols = String.length(Enum.at(grid, 0))

    Enum.map_reduce(grid, 0, fn row, row_num ->
      {
        String.graphemes(row)
        |> Enum.map_reduce(0, fn _cell, col_num ->
          {count_neighbors(grid, row_num, col_num, rows, cols), col_num + 1}
        end)
        |> elem(0),
        row_num + 1
      }
    end)
    |> elem(0)
    |> List.flatten()
    |> Enum.count(fn n -> n < 4 end)
  end

  def count_neighbors(grid, row, col, rows, cols) do
    cell = String.at(Enum.at(grid, row), col)
    count_neighbors(cell, grid, row, col, rows, cols)
  end

  def count_neighbors(cell, _grid, _row, _col, _rows, _cols) when cell != "@" do
    nil
  end

  def count_neighbors(_cell, grid, row, col, rows, cols) do
    directions = [{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}]

    Enum.reduce(directions, 0, fn {dr, dc}, acc ->
      acc + neighbor_val(grid, row + dr, col + dc, rows, cols)
    end)
  end

  defp neighbor_val(_grid, row, col, rows, cols)
       when row < 0 or row >= rows or col < 0 or col >= cols do
    0
  end

  defp neighbor_val(grid, row, col, rows, cols) do
    if String.at(Enum.at(grid, row), col) == ".", do: 0, else: 1
  end

  defp parse_rolls do
    File.stream!("lib/fixtures/day4.txt")
    |> Enum.map(&String.trim/1)
  end
end
