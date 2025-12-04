defmodule Day4Test do
  use ExUnit.Case

  @grid [
    ".@..",
    "@@@.",
    ".@.."
  ]
  @grid_rows length(@grid)
  @grid_cols String.length(Enum.at(@grid, 0))

  @gen2_grid [
    "....",
    ".@..",
    "...."
  ]

  @gen3_grid [
    "....",
    "....",
    "...."
  ]

  describe "neighbor counting" do
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

  describe "map evolution" do
    test "produces the next generation correctly" do
      assert Day4.evolve_one(@grid) == @gen2_grid
    end

    test "produces stable generation" do
      assert Day4.evolve_one(@gen2_grid) == @gen3_grid
    end

    test "stops evolving when stable" do
      assert Day4.evolve_all(@grid) == @gen3_grid
    end
  end

  describe "AOC quizes" do
    test "part1" do
      assert Day4.part1() == 1376
    end

    test "part2" do
      assert Day4.part2() == 8587
    end
  end
end
