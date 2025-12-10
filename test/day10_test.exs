defmodule Day10Test do
  use ExUnit.Case

  @input """
  [.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}
  [...#.] (0,2,3,4) (2,3) (0,4) (0,1,2) (1,2,3,4) {7,5,12,7,2}
  [.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5}
  """

  test "parsing" do
    machine_info = Day10.parse(@input)

    assert length(machine_info) == 3

    {lights, buttons, joltages} = Enum.at(machine_info, 1)

    assert lights == %{0 => false, 1 => false, 2 => false, 3 => true, 4 => false}
    assert buttons == [[0, 2, 3, 4], [2, 3], [0, 4], [0, 1, 2], [1, 2, 3, 4]]
    assert joltages == [7, 5, 12, 7, 2]
  end

  test "light transitions" do
    {lights, _, _} = Enum.at(Day10.parse(@input), 0)

    new_lights = Day10.push([3], lights)
    assert Map.get(new_lights, 3)

    new_lights = Day10.push([2], new_lights)
    refute Map.get(new_lights, 2)

    new_lights = Day10.push([2], new_lights)
    assert Map.get(new_lights, 2)
  end

  test "find shortest button sequence" do
    {lights, buttons, _} = Enum.at(Day10.parse(@input), 0)
    assert Day10.shortest_sequence(lights, buttons) == 2
  end

  test "part 1" do
    assert Day10.part1() == 488
  end
end
