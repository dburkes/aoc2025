defmodule Day11Test do
  use ExUnit.Case

  @input """
  aaa: you hhh
  you: bbb ccc
  bbb: ddd eee
  ccc: ddd eee fff
  ddd: ggg
  eee: out
  fff: out
  ggg: out
  hhh: ccc fff iii
  iii: out
  """

  test "parsing" do
    devices = Day11.parse(@input)
    assert map_size(devices) == 10

    aaa = Map.get(devices, "aaa")
    assert length(aaa) == 2
    assert Enum.at(aaa, 0) == "you"
    assert Enum.at(aaa, 1) == "hhh"
  end

  test "connection counting" do
    devices = Day11.parse(@input)
    assert Day11.count(devices, "you", "out") == 5
  end

  test "part 1" do
    assert Day11.part1() == 497
  end

  test "part 2" do
    assert Day11.part2() == 358_564_784_931_864
  end
end
