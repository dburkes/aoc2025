defmodule Day3Test do
  use ExUnit.Case

  describe "bank optimization" do
    test "leading digits" do
      assert Day3.maximize_bank(987_654_321_111_111, 2) == 98
      assert Day3.maximize_bank(987_654_321_111_111, 12) == 987_654_321_111
    end

    test "trailing digits" do
      assert Day3.maximize_bank(234_234_234_234_278, 2) == 78
      assert Day3.maximize_bank(234_934_234_234_278, 12) == 934_234_234_278
    end

    test "leading and trailing digits" do
      assert Day3.maximize_bank(811_111_111_111_119, 2) == 89
      assert Day3.maximize_bank(811_111_111_111_119, 12) == 811_111_111_119
    end

    test "scattered digits" do
      assert Day3.maximize_bank(818_181_911_112_111, 2) == 92
      assert Day3.maximize_bank(234_234_234_234_278, 12) == 434_234_234_278
      assert Day3.maximize_bank(818_181_911_112_111, 12) == 888_911_112_111
    end
  end

  describe "AOC quizes" do
    test "part1" do
      assert Day3.part1() == 17092
    end

    test "part2" do
      assert Day3.part2() == 170_147_128_753_455
    end
  end
end
