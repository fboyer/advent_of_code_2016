defmodule AdventOfCode2016.SquaresWithThreeSides do
  def count_valid_triangle_specs(specs) do
    specs
    |> String.split("\n", trim: true)
    |> Stream.map(&parse_specs/1)
    |> Stream.map(&Enum.sort/1)
    |> Enum.count(&is_valid?/1)
  end

  def count_valid_triangle_specs_in_col(specs) do
    specs
    |> String.split("\n", trim: true)
    |> Stream.map(&parse_specs/1)
    |> Stream.chunk(3)
    |> Stream.flat_map(&to_lines/1)
    |> Stream.map(&Enum.sort/1)
    |> Enum.count(&is_valid?/1)
  end

  def parse_specs(specs) do
    specs
    |> String.split
    |> Enum.map(&String.to_integer/1)
  end

  def is_valid?([side1, side2, side3 | []]), do: side1 + side2 > side3
  def is_valid?(_), do: false

  def to_lines([[triangle1_side1, triangle2_side1, triangle3_side1],
                              [triangle1_side2, triangle2_side2, triangle3_side2],
                              [triangle1_side3, triangle2_side3, triangle3_side3]
                              | []]) do
    [[triangle1_side1, triangle1_side2, triangle1_side3],
     [triangle2_side1, triangle2_side2, triangle2_side3],
     [triangle3_side1, triangle3_side2, triangle3_side3]]
  end
  def to_lines(_), do: []
end
