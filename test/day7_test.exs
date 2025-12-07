defmodule Day7Test do
  use ExUnit.Case

  @input """
  .......S.......
  ...............
  .......^.......
  ...............
  ......^.^......
  ...............
  .....^.^.^.....
  ...............
  ....^.^...^....
  ...............
  ...^.^...^.^...
  ...............
  ..^...^.....^..
  ...............
  .^.^.^.^.^...^.
  ...............
  """

  test "parsing" do
    {start_col, splitters} = Day7.parse(@input)
    assert start_col == 7
    assert length(splitters) == 15
    assert MapSet.size(Enum.at(splitters, 1)) == 1
    assert MapSet.size(Enum.at(splitters, 3)) == 2
    assert MapSet.size(Enum.at(splitters, 5)) == 3
    assert MapSet.size(Enum.at(splitters, 7)) == 3
    assert MapSet.size(Enum.at(splitters, 9)) == 4
    assert MapSet.size(Enum.at(splitters, 11)) == 3
    assert MapSet.size(Enum.at(splitters, 13)) == 6
  end

  test "conventional beam casting" do
    splits = Day7.parse(@input) |> Day7.cast_conventional()
    assert splits == 21
  end

  test "quantum beam casting" do
    worlds = Day7.parse(@input) |> Day7.cast_quantum()
    assert worlds == 40
  end

  test "part1" do
    assert Day7.part1() == 1518
  end

  test "part2" do
    assert Day7.part2() == 25_489_586_715_621
  end
end
