defmodule Day3Test do
  use ExUnit.Case

  describe "bank optimization" do
    test "leading digits" do
      assert Day3.maximize_bank(987654321111111, 2) == 98
      assert Day3.maximize_bank(987654321111111, 12) == 987654321111
    end

    test "trailing digits" do
      assert Day3.maximize_bank(234234234234278, 2) == 78
      assert Day3.maximize_bank(234934234234278, 12) == 934234234278
    end

    test "leading and trailing digits" do
      assert Day3.maximize_bank(811111111111119, 2) == 89
      assert Day3.maximize_bank(811111111111119, 12) == 811111111119
    end

    test "scattered digits" do
      assert Day3.maximize_bank(818181911112111, 2) == 92
      assert Day3.maximize_bank(234234234234278, 12) == 434234234278
      assert Day3.maximize_bank(818181911112111, 12) == 888911112111
    end
  end

  describe "AOC quizes" do
    test "part1" do
      assert Day3.part1() == 17092
    end

    test "part2" do
      assert Day3.part2() == 170147128753455
    end

  end
end
