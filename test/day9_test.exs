defmodule Day9Test do
  use ExUnit.Case

  @input """
  7,1
  11,1
  11,7
  9,7
  9,5
  2,5
  2,3
  7,3
  """

  test "parsing" do
    tiles = Day9.parse(@input)
    assert length(tiles) == 8
    assert Enum.at(tiles, 0) == {7, 1}
    assert Enum.at(tiles, 7) == {7, 3}
  end

  test "area calculation" do
    assert Day9.area({{2, 5}, {9, 7}}) == 24
    assert Day9.area({{7, 1}, {11, 7}}) == 35
    assert Day9.area({{7, 3}, {2, 3}}) == 6
    assert Day9.area({{2, 5}, {11, 1}}) == 50
  end

  test "within?" do
    tiles = Day9.parse(@input)
    refute Day9.within?({{7, 1}, {11, 7}}, tiles)
    assert Day9.within?({{7, 3}, {2, 3}}, tiles)
    assert Day9.within?({{2, 5}, {9, 7}}, tiles)
    refute Day9.within?({{2, 5}, {11, 1}}, tiles)
  end

  test "part 1" do
    assert Day9.part1() == 4_725_826_296
  end

  test "part 2" do
    assert Day9.part2() == 1_637_556_834
  end
end
