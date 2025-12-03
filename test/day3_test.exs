defmodule Day3Test do
  use ExUnit.Case

  describe "bank optimization" do
    test "first two digits" do
      assert Day3.maximize_bank(987654321111111) == 98
    end

    test "last two digits" do
      assert Day3.maximize_bank(234234234234278) == 78
    end

    test "first and last digits" do
      assert Day3.maximize_bank(811111111111119) == 89
    end

    test "two interior digits" do
      assert Day3.maximize_bank(818181911112111) == 92
    end
  end

  describe "AOC quizes" do
    test "part1" do
      assert Day3.part1() == 17092
    end
  end
end
