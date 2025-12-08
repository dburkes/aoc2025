defmodule Day8Test do
  use ExUnit.Case

  @input """
  162,817,812
  57,618,57
  906,360,560
  592,479,940
  352,342,300
  466,668,158
  542,29,236
  431,825,988
  739,650,466
  52,470,668
  216,146,977
  819,987,18
  117,168,530
  805,96,715
  346,949,466
  970,615,88
  941,993,340
  862,61,35
  984,92,344
  425,690,689
  """

  test "parsing" do
    boxes = Day8.parse(@input)
    assert length(boxes) == 20
    assert Enum.at(boxes, 0) == {162, 817, 812}
    assert Enum.at(boxes, 19) == {425, 690, 689}
  end

  test "distance calculation" do
    boxes = Day8.parse(@input)
    assert Day8.distance(Enum.at(boxes, 0), Enum.at(boxes, 1)) == 787.814064357828
  end

  test "finding distances" do
    boxes = Day8.parse(@input)
    distances = Day8.distances(boxes)
    # assert(length(distances) == length(boxes) * 2 - 1)
    assert Enum.at(distances, 0) == [{162, 817, 812}, {425, 690, 689}]
    assert Enum.at(distances, 1) == [{162, 817, 812}, {431, 825, 988}]
    assert Enum.at(distances, 2) == [{805, 96, 715}, {906, 360, 560}]
  end

  test "creating circuits" do
    boxes = Day8.parse(@input)
    {circuits, _} = Day8.create_circuits(boxes, 3)
    circuit_map = MapSet.new(circuits)

    assert MapSet.member?(
             circuit_map,
             MapSet.new([{162, 817, 812}, {425, 690, 689}, {431, 825, 988}])
           )

    assert MapSet.member?(circuit_map, MapSet.new([{906, 360, 560}, {805, 96, 715}]))
  end

  test "creating a single circuit" do
    boxes = Day8.parse(@input)
    {circuits, _} = Day8.create_mega_circuit(boxes)
    assert length(circuits) == 1
    assert MapSet.size(List.first(circuits)) == 20
  end

  test "part1" do
    assert Day8.part1() == 123_930
  end

  test "part2" do
    assert Day8.part2() == 27_338_688
  end
end
