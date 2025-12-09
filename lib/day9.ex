defmodule Day9 do
  def part1() do
    tiles = parse()

    for p1 <- tiles,
        p2 <- tiles,
        p1 != p2 do
      area({p1, p2})
    end
    |> Enum.max()
  end

  def part2() do
    tiles = parse()

    for p1 <- tiles,
        p2 <- tiles,
        within?({p1, p2}, tiles) do
      area({p1, p2})
    end
    |> Enum.max()
  end

  def within?({{x1, y1}, {x2, y2}}, points) do
    points
    |> pairs()
    |> Enum.all?(&inside?(&1, x1, y1, x2, y2))
  end

  defp pairs(points) do
    Enum.zip(points, tl(points) ++ [hd(points)])
  end

  defp inside?({{px1, py1}, {px2, py2}}, x1, y1, x2, y2) do
    max(px1, px2) <= min(x1, x2) or
      min(px1, px2) >= max(x1, x2) or
      max(py1, py2) <= min(y1, y2) or
      min(py1, py2) >= max(y1, y2)
  end

  def area({{x1, y1}, {x2, y2}}) do
    (abs(x2 - x1) + 1) * (abs(y2 - y1) + 1)
  end

  def parse(input \\ File.read!("lib/fixtures/day9.txt")) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, ","))
    |> Enum.map(fn [x, y] -> {String.to_integer(x), String.to_integer(y)} end)
  end
end
