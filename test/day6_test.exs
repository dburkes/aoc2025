defmodule Day6Test do
  use ExUnit.Case

  @input """
  8   626 55
  752 33  21
  +   *   *
  """

  test "normal parsing" do
    {:ok, stream} = StringIO.open(@input)
    io = IO.binstream(stream, :line)

    {numbers, operators} = Day6.parse_conventional(io)

    assert(length(numbers) == 3)
    assert(Enum.at(numbers, 0) == [8, 752])
    assert(Enum.at(numbers, 1) == [626, 33])
    assert(Enum.at(numbers, 2) == [55, 21])
    assert operators == ["+", "*", "*"]
  end

  test "rtl parsing" do
    {:ok, stream} = StringIO.open(@input)
    io = IO.binstream(stream, :line)

    {numbers, operators} = Day6.parse_rtl(io)

    assert(length(numbers) == 3)
    assert(Enum.at(numbers, 0) == [2, 5, 87])
    assert(Enum.at(numbers, 1) == [6, 23, 63])
    assert(Enum.at(numbers, 2) == [51, 52])
    assert operators == ["+", "*", "*"]
  end

  test "processing" do
    assert(Day6.process([8, 752, 2], "+") == 762)
    assert(Day6.process([626, 2, 1], "*") == 1252)
  end

  test "part1" do
    assert Day6.part1() == 7_098_065_460_541
  end

  test "part2" do
    assert Day6.part2() == 13_807_151_830_618
  end
end
