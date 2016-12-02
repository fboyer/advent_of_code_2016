defmodule AdventOfCode2016.NoTimeForATaxiCab do
  @north "North"
  @south "South"
  @east "East"
  @west "West"

  def distance_to_final_location(instructions) do
    {_dir, {x, y}} = instructions |> final_location
    abs(x) + abs(y)
  end

  def final_location(instructions) do
    instructions
    |> parse_instructions
    |> Enum.reduce({@north, {0, 0}}, fn({left_or_right, dist}, acc) ->
        turn_and_move(left_or_right, dist, acc)
      end)
  end

  def turn_and_move(left_or_right, dist, {current_dir, current_loc}) do
    new_dir = current_dir |> turn(left_or_right)
    new_loc = current_loc |> move(new_dir, dist)
    {new_dir, new_loc}
  end

  def distance_to_first_location_visited_twice(instructions) do
    {_dir, {x, y}, _visited_locations} = instructions |> first_location_visited_twice
    abs(x) + abs(y)
  end

  def first_location_visited_twice(instructions) do
    instructions
    |> parse_instructions
    |> Enum.reduce_while({@north, {0, 0}, %{{0, 0} => 1}}, fn({left_or_right, dist}, acc) ->
      visit_locations(left_or_right, dist, acc)
    end)
  end

  def visit_locations(left_or_right, dist, {current_dir, current_loc, visited_locations}) do
    current_dir
    |> turn(left_or_right)
    |> do_visit_locations(dist, current_loc, visited_locations)
  end
  def do_visit_locations(dir, 0, current_loc, visited_locations), do: {:cont, {dir, current_loc, visited_locations}}
  def do_visit_locations(dir, dist, current_loc, visited_locations) do
    new_loc = move(current_loc, dir, 1)
    case Map.has_key?(visited_locations, new_loc) do
      true ->
        visited_locations = Map.put(visited_locations, new_loc, 1)
        {:halt, {dir, new_loc, visited_locations}}
      false ->
        visited_locations = Map.put(visited_locations, new_loc, 1)
        do_visit_locations(dir, dist - 1, new_loc, visited_locations)
    end
  end

  def parse_instructions(instructions) do
    instructions
    |> String.split(", ")
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(fn [left_or_right | dist] -> {left_or_right, dist |> Enum.join |> String.to_integer} end)
  end

  def turn(@north, "L"), do: @west
  def turn(@north, "R"), do: @east
  def turn(@south, "L"), do: @east
  def turn(@south, "R"), do: @west
  def turn(@east, "L"), do: @north
  def turn(@east, "R"), do: @south
  def turn(@west, "L"), do: @south
  def turn(@west, "R"), do: @north

  def move({x, y}, @north, dist), do: {x, y + dist}
  def move({x, y}, @south, dist), do: {x, y - dist}
  def move({x, y}, @east, dist), do: {x + dist, y}
  def move({x, y}, @west, dist), do: {x - dist, y}
end
