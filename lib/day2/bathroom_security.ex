defmodule AdventOfCode2016.BathroomSecurity do
  @normal "normal"
  @fu "fu"

  def get_bathroom_code(keypad_type, instructions) do
    instructions
    |> String.split("\n", trim: true)
    |> Enum.reduce([], fn(instructions_line, keys) ->
      keys
      |> List.insert_at(-1, get_next_key(keypad_type, instructions_line, keys))
    end)
    |> Enum.join
  end

  def get_next_key(keypad_type, instructions_line, previous_keys) do
    last_key =
      case List.last(previous_keys) do
        nil -> "5"
        _ -> List.last(previous_keys)
      end

    instructions_line
    |> String.graphemes
    |> Enum.reduce(last_key, fn(instruction, current_key) ->
      move(keypad_type, instruction, current_key)
    end)
  end

  #
  # Normal keypad
  #
  def move(@normal, "U", "1"), do: "1"
  def move(@normal, "D", "1"), do: "4"
  def move(@normal, "L", "1"), do: "1"
  def move(@normal, "R", "1"), do: "2"
  def move(@normal, "U", "2"), do: "2"
  def move(@normal, "D", "2"), do: "5"
  def move(@normal, "L", "2"), do: "1"
  def move(@normal, "R", "2"), do: "3"
  def move(@normal, "U", "3"), do: "3"
  def move(@normal, "D", "3"), do: "6"
  def move(@normal, "L", "3"), do: "2"
  def move(@normal, "R", "3"), do: "3"
  def move(@normal, "U", "4"), do: "1"
  def move(@normal, "D", "4"), do: "7"
  def move(@normal, "L", "4"), do: "4"
  def move(@normal, "R", "4"), do: "5"
  def move(@normal, "U", "5"), do: "2"
  def move(@normal, "D", "5"), do: "8"
  def move(@normal, "L", "5"), do: "4"
  def move(@normal, "R", "5"), do: "6"
  def move(@normal, "U", "6"), do: "3"
  def move(@normal, "D", "6"), do: "9"
  def move(@normal, "L", "6"), do: "5"
  def move(@normal, "R", "6"), do: "6"
  def move(@normal, "U", "7"), do: "4"
  def move(@normal, "D", "7"), do: "7"
  def move(@normal, "L", "7"), do: "7"
  def move(@normal, "R", "7"), do: "8"
  def move(@normal, "U", "8"), do: "5"
  def move(@normal, "D", "8"), do: "8"
  def move(@normal, "L", "8"), do: "7"
  def move(@normal, "R", "8"), do: "9"
  def move(@normal, "U", "9"), do: "6"
  def move(@normal, "D", "9"), do: "9"
  def move(@normal, "L", "9"), do: "8"
  def move(@normal, "R", "9"), do: "9"

  #
  # F'ed up keypad
  #
  def move(@fu, "U", "1"), do: "1"
  def move(@fu, "D", "1"), do: "3"
  def move(@fu, "L", "1"), do: "1"
  def move(@fu, "R", "1"), do: "1"
  def move(@fu, "U", "2"), do: "2"
  def move(@fu, "D", "2"), do: "6"
  def move(@fu, "L", "2"), do: "2"
  def move(@fu, "R", "2"), do: "3"
  def move(@fu, "U", "3"), do: "1"
  def move(@fu, "D", "3"), do: "7"
  def move(@fu, "L", "3"), do: "2"
  def move(@fu, "R", "3"), do: "4"
  def move(@fu, "U", "4"), do: "4"
  def move(@fu, "D", "4"), do: "8"
  def move(@fu, "L", "4"), do: "3"
  def move(@fu, "R", "4"), do: "4"
  def move(@fu, "U", "5"), do: "5"
  def move(@fu, "D", "5"), do: "5"
  def move(@fu, "L", "5"), do: "5"
  def move(@fu, "R", "5"), do: "6"
  def move(@fu, "U", "6"), do: "2"
  def move(@fu, "D", "6"), do: "A"
  def move(@fu, "L", "6"), do: "5"
  def move(@fu, "R", "6"), do: "7"
  def move(@fu, "U", "7"), do: "3"
  def move(@fu, "D", "7"), do: "B"
  def move(@fu, "L", "7"), do: "6"
  def move(@fu, "R", "7"), do: "8"
  def move(@fu, "U", "8"), do: "4"
  def move(@fu, "D", "8"), do: "C"
  def move(@fu, "L", "8"), do: "7"
  def move(@fu, "R", "8"), do: "9"
  def move(@fu, "U", "9"), do: "9"
  def move(@fu, "D", "9"), do: "9"
  def move(@fu, "L", "9"), do: "8"
  def move(@fu, "R", "9"), do: "9"
  def move(@fu, "U", "A"), do: "6"
  def move(@fu, "D", "A"), do: "A"
  def move(@fu, "L", "A"), do: "A"
  def move(@fu, "R", "A"), do: "B"
  def move(@fu, "U", "B"), do: "7"
  def move(@fu, "D", "B"), do: "D"
  def move(@fu, "L", "B"), do: "A"
  def move(@fu, "R", "B"), do: "C"
  def move(@fu, "U", "C"), do: "8"
  def move(@fu, "D", "C"), do: "C"
  def move(@fu, "L", "C"), do: "B"
  def move(@fu, "R", "C"), do: "C"
  def move(@fu, "U", "D"), do: "B"
  def move(@fu, "D", "D"), do: "D"
  def move(@fu, "L", "D"), do: "D"
  def move(@fu, "R", "D"), do: "D"
end
