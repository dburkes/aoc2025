defmodule Day1Test do
  use ExUnit.Case

  describe "move processing" do
    test "right move without zero crossing" do
      assert Day1.process_move(50, "R", 30) == {80, 0}
    end

    test "right move with zero crossing" do
      assert Day1.process_move(90, "R", 20) == {10, 1}
    end

    test "right move with multiple zero crossings" do
      assert Day1.process_move(90, "R", 250) == {40, 3}
    end

    test "right move landing on zero" do
      assert Day1.process_move(80, "R", 20) == {0, 0}
    end

    test "right move landing on zero with single crossing" do
      assert Day1.process_move(90, "R", 110) == {0, 1}
    end

    test "right move landing on zero with multiple crossings" do
      assert Day1.process_move(90, "R", 210) == {0, 2}
    end

    test "right move starting at zero" do
      assert Day1.process_move(0, "R", 20) == {20, 0}
    end

    test "right move starting at zero and landing on zero with no crossings" do
      assert Day1.process_move(0, "R", 100) == {0, 0}
    end

    test "right move starting at zero and landing on zero with crossings" do
      assert Day1.process_move(0, "R", 300) == {0, 2}
    end

    test "left move with zero crossing" do
      assert Day1.process_move(10, "L", 20) == {90, 1}
    end

    test "left move with multiple zero crossings" do
      assert Day1.process_move(10, "L", 250) == {60, 3}
    end

    test "left move landing on zero" do
      assert Day1.process_move(20, "L", 20) == {0, 0}
    end

    test "left move landing on zero with single crossing" do
      assert Day1.process_move(10, "L", 110) == {0, 1}
    end

    test "left move landing on zero with multiple crossings" do
      assert Day1.process_move(10, "L", 210) == {0, 2}
    end

    test "left move starting at zero" do
      assert Day1.process_move(0, "L", 20) == {80, 0}
    end
  end

  describe "AOC quizes" do
    test "part1" do
      assert Day1.part1() == 1021
    end

    test "part2" do
      assert Day1.part2() == 5933
    end
  end
end
