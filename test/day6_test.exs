defmodule Day6Test do
  use ExUnit.Case

  @input """
  8   626 55
  752 33  21
  +   *   *
  """

  test "normal parsing" do
    assert Day6.parse_conventional(@input) == [
             {[8, 752], :+},
             {[626, 33], :*},
             {[55, 21], :*}
           ]
  end

  test "rtl parsing" do
    assert Day6.parse_rtl(@input) == [
             {[2, 5, 87], :+},
             {[6, 23, 63], :*},
             {[51, 52], :*}
           ]
  end

  test "part1" do
    assert Day6.part1() == 7_098_065_460_541
  end

  test "part2" do
    assert Day6.part2() == 13_807_151_830_618
  end
end
