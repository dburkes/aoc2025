defmodule Day10 do
  defmodule Combinations do
    def comb(0, _), do: [[]]
    def comb(_, []), do: []

    def comb(m, [h | t]) do
      # Combinations including the head element
      included = for l <- comb(m - 1, t), do: [h | l]
      # Combinations excluding the head element
      excluded = comb(m, t)
      included ++ excluded
    end
  end

  def part1() do
    parse()
    |> Enum.map(fn {lights, buttons, _} -> shortest_sequence(lights, buttons) end)
    |> Enum.sum()
  end

  def shortest_sequence(lights, buttons) do
    num_lights = length(Map.keys(lights))

    button_deltas =
      buttons
      |> Enum.map(fn button ->
        0..(num_lights - 1)
        |> Enum.reduce([], fn n, acc ->
          [Enum.member?(button, n) | acc]
        end)
        |> List.flatten()
        |> Enum.reverse()
      end)

    desired_effect = lights |> Enum.map(fn {_, v} -> if v, do: 1, else: 0 end)

    1..length(buttons)
    |> Enum.reduce_while(nil, fn n, _ ->
      combos = Combinations.comb(n, button_deltas)

      net_effects =
        combos
        |> Enum.map(fn effects ->
          net_effect = List.duplicate(0, num_lights)

          Enum.reduce(effects, net_effect, fn effect, acc ->
            acc =
              0..(num_lights - 1)
              |> Enum.reduce(acc, fn n, acc ->
                this_effect = Enum.at(effect, n)

                List.update_at(acc, n, fn val ->
                  if this_effect, do: rem(val + 1, 2), else: val
                end)
              end)

            acc
          end)
        end)

      if Enum.member?(net_effects, desired_effect), do: {:halt, n}, else: {:cont, nil}
    end)
  end

  def push(buttons, lights) do
    Enum.reduce(buttons, lights, fn button, acc ->
      Map.update!(acc, button, &(!&1))
    end)
  end

  def parse(input \\ File.read!("lib/fixtures/day10.txt")) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn str ->
      lights =
        Regex.scan(~r/\[([\.#]+)\]/, str, capture: :all_but_first)
        |> List.flatten()
        |> Enum.at(0)
        |> String.graphemes()
        |> Enum.with_index()
        |> Enum.reduce(%{}, fn {s, num}, acc ->
          Map.put(acc, num, s == "#")
        end)

      buttons =
        Regex.scan(~r/\(([\d,?]+)\)/, str, capture: :all_but_first)
        |> List.flatten()
        |> Enum.map(fn b ->
          String.split(b, ",")
          |> Enum.map(&String.to_integer/1)
        end)

      joltages =
        Regex.scan(~r/{([\d,?]+)}/, str, capture: :all_but_first)
        |> List.flatten()
        |> Enum.at(0)
        |> String.split(",")
        |> Enum.map(&String.to_integer/1)

      {lights, buttons, joltages}
    end)
  end
end
