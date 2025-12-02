defmodule Day2Test do
  use ExUnit.Case

  describe "invalid ID detection" do
    test "odd length ID is valid" do
      assert Day2.invalid_id?([1, 2, 3]) == false
    end

    test "even length ID with matching halves is invalid" do
      assert Day2.invalid_id?([1, 2, 1, 2]) == true
    end

    test "even length ID with non-matching halves is valid" do
      assert Day2.invalid_id?([1, 2, 3, 4]) == false
    end
  end

  describe "AOC quizes" do
    test "part1" do
      assert Day2.part1() == 13919717792
    end
  end
end
