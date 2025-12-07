defmodule Day6Test do
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
    {grid, beam} = Day7.parse(@input)
    assert length(grid) == 16
    assert beam == 7
  end

  test "beam casting" do
    {grid, beam} = Day7.parse(@input)
    splits = 0

    {_, beams, splits} = Day7.cast_beams(grid, [beam], splits, 1)
    assert beams == [7]
    assert splits == 0

    {_, beams, splits} = Day7.cast_beams(grid, beams, splits, 2)
    assert beams == [6, 8]
    assert splits == 1

    {_, beams, splits} = Day7.cast_beams(grid, beams, splits, 3)
    assert beams == [6, 8]
    assert splits == 1

    {_, beams, splits} = Day7.cast_beams(grid, beams, splits, 4)
    assert beams == [5, 7, 9]
    assert splits == 3
  end

  test "part1" do
    assert Day7.part1() == 1518
  end
end
