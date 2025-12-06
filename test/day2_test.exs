defmodule Day2Test do
  use ExUnit.Case

  describe "invalid ID detection without multiple repeats" do
    test "odd length ID is valid" do
      assert Day2.invalid_id?([1, 1, 1]) == false
    end

    test "even length ID with matching halves is invalid" do
      assert Day2.invalid_id?([1, 2, 1, 2]) == true
    end

    test "even length ID with non-matching halves is valid" do
      assert Day2.invalid_id?([1, 2, 3, 4]) == false
    end
  end

  describe "invalid ID detection with multiple repeats" do
    test "single digit ID is valid" do
      assert Day2.invalid_id?([1], true) == false
    end

    test "odd length ID with all same digits is invalid" do
      assert Day2.invalid_id?([2, 2, 2, 2, 2], true) == true
    end

    test "odd length ID with differing digits is valid" do
      assert Day2.invalid_id?([2, 2, 3, 2, 1], true) == false
    end

    test "odd length ID with multiple repeats is invalid" do
      assert Day2.invalid?([1, 2, 3, 1, 2, 3, 1, 2, 3], true) == true
    end

    test "even length ID with matching halves is invalid" do
      assert Day2.invalid_id?([3, 4, 3, 4], true) == true
    end

    test "even length ID with non-matching halves is valid" do
      assert Day2.invalid_id?([3, 4, 5, 6], true) == false
    end

    test "even length ID with multiple repeats is invalid" do
      assert Day2.invalid?([2, 1, 2, 1, 2, 1, 2, 1, 2, 1], true) == true
    end
  end

  describe "AOC quizes" do
    test "part1" do
      assert Day2.part1() == 13_919_717_792
    end

    test "part2" do
      assert Day2.part2() == 14_582_313_461
    end
  end
end
