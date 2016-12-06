defmodule AdventOfCode2016Test.NoTimeForATaxiCab do
  use ExUnit.Case
  doctest AdventOfCode2016.NoTimeForATaxiCab

  import AdventOfCode2016.NoTimeForATaxiCab

  @input "L2, L5, L5, R5, L2, L4, R1, R1, L4, R2, R1, L1, L4, R1, L4, L4, R5, R3, R1, L1, R1, L5, L1, R5, L4, R2, L5, L3, L3, R3, L3, R4, R4, L2, L5, R1, R2, L2, L1, R3, R4, L193, R3, L5, R45, L1, R4, R79, L5, L5, R5, R1, L4, R3, R3, L4, R185, L5, L3, L1, R5, L2, R1, R3, R2, L3, L4, L2, R2, L3, L2, L2, L3, L5, R3, R4, L5, R1, R2, L2, R4, R3, L4, L3, L1, R3, R2, R1, R1, L3, R4, L5, R2, R1, R3, L3, L2, L2, R2, R1, R2, R3, L3, L3, R4, L4, R4, R4, R4, L3, L1, L2, R5, R2, R2, R2, L4, L3, L4, R4, L5, L4, R2, L4, L4, R4, R1, R5, L2, L4, L5, L3, L2, L4, L4, R3, L3, L4, R1, L2, R3, L2, R1, R2, R5, L4, L2, L1, L3, R2, R3, L2, L1, L5, L2, L1, R4"

  test "can parse the input instructions" do
    assert parse_instructions("R2, L3") == [{"R", 2}, {"L", 3}]
    assert parse_instructions("R2, R2, R2") == [{"R", 2}, {"R", 2}, {"R", 2}]
    assert parse_instructions("R5, L5, R5, R3") == [{"R", 5}, {"L", 5}, {"R", 5}, {"R", 3}]
  end

  test "can change direction" do
    assert turn("North", "L") == "West"
    assert turn("North", "R") == "East"
    assert turn("South", "L") == "East"
    assert turn("South", "R") == "West"
    assert turn("East", "L") == "North"
    assert turn("East", "R") == "South"
    assert turn("West", "L") == "South"
    assert turn("West", "R") == "North"
  end

  test "can move a certain distance" do
    assert move({0, 0}, "North", 1) == {0, 1}
    assert move({1, 1}, "South", 2) == {1, -1}
    assert move({2, 3}, "East", 3) == {5, 3}
    assert move({3, -2}, "West", 4) == {-1, -2}
  end

  test "can determine the final location" do
    assert final_location("R2, L3") == {"North", {2, 3}}
    assert final_location("R2, R2, R2") == {"West", {0, -2}}
    assert final_location("R5, L5, R5, R3") == {"South", {10, 2}}
  end

  test "can calculate the taxicab grid distance to the final location" do
    assert distance_to_final_location("R2, L3") == 5
    assert distance_to_final_location("R2, R2, R2") == 2
    assert distance_to_final_location("R5, L5, R5, R3") == 12
  end

  test "can solve the day 1 - puzzle 1" do
    answer =
      @input
      |> distance_to_final_location
      |> Integer.to_string

    IO.puts "Day 1 - Puzzle 1: " <> answer
  end

  test "can visit locations" do
    assert visit_locations("L", 4, {"East", {1, -2}, %{{1, -2} => 1}}) ==
      {:cont, {"North", {1, 2}, %{{1, -2} => 1, {1, -1} => 1, {1, 0} => 1, {1, 1} => 1, {1, 2} => 1}}}
    assert visit_locations("R", 1, {"South", {0, 0}, %{{0, 0} => 1}}) ==
      {:cont, {"West", {-1, 0}, %{{0, 0} => 1, {-1, 0} => 1}}}
    assert visit_locations("R", 3, {"North", {-1, 1}, %{{-1, 1} => 1}}) ==
      {:cont, {"East", {2, 1}, %{{-1, 1} => 1, {0, 1} => 1, {1, 1} => 1, {2, 1} => 1}}}
  end

  test "can calculate the taxicab grid distance to the first location visited twice" do
    assert first_location_visited_twice("R8, R4, R4, R8") ==
      {"North", {4, 0}, %{{0, 0} => 1, {1, 0} => 1, {2, 0} => 1, {3, 0} => 1,
                {4, 0} => 1, {5, 0} => 1, {6, 0} => 1, {7, 0} => 1,
                {8, 0} => 1, {8, -1} => 1, {8, -2} => 1, {8, -3} => 1,
                {8, -4} => 1, {7, -4} => 1, {6, -4} => 1, {5, -4} => 1,
                {4, -4} => 1, {4, -3} => 1, {4, -2} => 1, {4, -1} => 1}}
  end

  test "can solve the day 2 - puzzle 2" do
    answer =
      @input
      |> distance_to_first_location_visited_twice
      |> Integer.to_string

    IO.puts "Day 1 - Puzzle 2: " <> answer
  end
end
