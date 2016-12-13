defmodule AdventOfCode2016.SquaresWithThreeSidesTest do
  use ExUnit.Case
  doctest AdventOfCode2016.SquaresWithThreeSides

  import AdventOfCode2016.SquaresWithThreeSides

  describe "day 3 - part 1" do
    test "can parse specs to integer values" do
      assert parse_specs("  5   10   25") == [5, 10, 25]
      assert parse_specs(" 14    5   10") == [14, 5, 10]
    end

    test "sum of any two sides is larger than the remaining side" do
      assert is_valid?([5, 10, 25]) == false
      assert is_valid?([14, 5, 10]) == true
    end

    test "can count the number of valid specifications" do
      input = """
      5 10 25
      14 5 10
      """

      assert count_valid_triangle_specs(input) == 1
    end

    test "can solve the day 3 - part 1" do
      answer =
        File.read!("test/day3/day3.txt")
        |> count_valid_triangle_specs

        IO.puts "day 3 - part 1: #{inspect answer}"
    end
  end

  describe "day 3 - part 2" do
    test "can count the number of valid column specifications" do
      input = """
      5 14 3
      10 5 4
      25 10 5
      """

      assert count_valid_triangle_specs_in_col(input) == 2
    end

    test "can solve the day 3 - part 2" do
      answer =
        File.read!("test/day3/day3.txt")
        |> count_valid_triangle_specs_in_col

        IO.puts "day 3 - part 2: #{inspect answer}"
    end
  end
end
