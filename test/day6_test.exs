defmodule Day6Test do
  use ExUnit.Case

  @input """
  8   626 55
  752 333 21
  +   *   *
  """

  test "parsing" do
    {:ok, stream} = StringIO.open(@input)
    io = IO.binstream(stream, :line)

    {numbers, operators} = Day6.parse_input(io)

    assert(length(numbers) == 3)
    assert(Enum.at(numbers, 0) == [8, 752])
    assert(Enum.at(numbers, 1) == [626, 333])
    assert(Enum.at(numbers, 2) == [55, 21])
    assert operators == ["+", "*", "*"]
  end

  test "processing" do
    assert(Day6.process([8, 752, 2], "+") == 762)
    assert(Day6.process([626, 2, 1], "*") == 1252)
  end

  test "part1" do
    assert Day6.part1() == 7_098_065_460_541
  end
end
