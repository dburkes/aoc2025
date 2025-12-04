defmodule Day4Test do
  use ExUnit.Case

  describe "free roll detection" do
    test "works" do
      # @.@.
      # @@@@
      # @.@.
      grid = MapSet.new([
        {0, 0},
        {0, 2},
        {1, 0},
        {1, 1},
        {1, 2},
        {1, 3},
        {2, 0},
        {2, 2}
      ])

      assert Day4.roll_free?(grid, {0, 0})
      assert Day4.roll_free?(grid, {0, 2})
      assert Day4.roll_free?(grid, {1, 0})
      refute Day4.roll_free?(grid, {1, 1})
      refute Day4.roll_free?(grid, {1, 2})
      assert Day4.roll_free?(grid, {1, 3})
      assert Day4.roll_free?(grid, {2, 0})
      assert Day4.roll_free?(grid, {2, 2})
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
