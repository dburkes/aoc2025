defmodule Day4Test do
  use ExUnit.Case

  describe "neighbor counting" do
    @grid [
      ".@..",
      "@@@.",
      ".@.."
    ]
    @grid_rows length(@grid)
    @grid_cols String.length(Enum.at(@grid, 0))

    test "with all eight neighbors" do
      assert Day4.count_neighbors(@grid, 1, 1, @grid_rows, @grid_cols) == 4
    end

    test "on the first row" do
      assert Day4.count_neighbors(@grid, 0, 1, @grid_rows, @grid_cols) == 3
    end

    test "on the last row" do
      assert Day4.count_neighbors(@grid, 2, 1, @grid_rows, @grid_cols) == 3
    end

    test "on the first column" do
      assert Day4.count_neighbors(@grid, 1, 0, @grid_rows, @grid_cols) == 3
    end

    test "on the last column" do
      assert Day4.count_neighbors(@grid, 1, 2, @grid_rows, @grid_cols) == 3
    end
  end

  describe "AOC quizes" do
    test "part1" do
      assert Day4.part1() == 1376
    end

    test "part2" do
    end
  end
end
