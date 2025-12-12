defmodule Day11Test do
  use ExUnit.Case

  @input """
  0:
  ###
  ##.
  ##.

  1:
  ###
  ##.
  .##

  2:
  .##
  ###
  ##.

  3:
  ##.
  ###
  ##.

  4:
  ###
  #..
  ###

  5:
  ###
  .#.
  ###

  4x4: 0 0 0 0 2 0
  12x5: 1 0 1 0 2 2
  12x5: 1 0 1 0 3 2
  """

  test "parsing" do
    data = Day12.parse(@input)
    shapes = Map.get(data, :shapes)
    regions = Map.get(data, :regions)

    assert length(shapes) == 6
    assert length(regions) == 3

    shape = Enum.at(shapes, 1)
    assert shape == ["###", "##.", ".##"]

    region = Enum.at(regions, 0)
    assert Map.get(region, :width) == 4
    assert Map.get(region, :height) == 4
    assert Map.get(region, :counts) == [0, 0, 0, 0, 2, 0]
  end

  test "part1" do
    assert Day12.part1() == 569
  end
end
