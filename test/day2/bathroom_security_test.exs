defmodule AdventOfCode2016.BathroomSecurityTest do
  use ExUnit.Case
  doctest AdventOfCode2016.BathroomSecurity

  import AdventOfCode2016.BathroomSecurity

  describe "day 2 - part 1" do
    test "can move in all directions" do
      assert move(:normal, "R", "1") == "2"
      assert move(:normal, "D", "3") == "6"
      assert move(:normal, "L", "9") == "8"
      assert move(:normal, "U", "7") == "4"
    end

    test "cannot move outside of the keypad" do
      assert move(:normal, "U", "1") == "1"
      assert move(:normal, "R", "3") == "3"
      assert move(:normal, "D", "9") == "9"
      assert move(:normal, "L", "7") == "7"
    end

    test "can find the next valid key" do
      assert get_next_key(:normal, "ULL", []) == "1"
      assert get_next_key(:normal, "RRDDD", ["1"]) == "9"
      assert get_next_key(:normal, "LURDL", ["1", "9"]) == "8"
      assert get_next_key(:normal, "UUUUD", ["1", "9", "8"]) == "5"
    end

    test "can find the bathroom code" do
      instructions = """
      ULL
      RRDDD
      LURDL
      UUUUD
      """

      assert get_bathroom_code(instructions, [keypad_type: :normal]) == "1985"
    end

    test "can solve the day 2 - part 1" do
      answer =
        File.read!("test/day2/day2.txt")
        |> get_bathroom_code([keypad_type: :normal])

        IO.puts "day 2 - part 1: #{answer}"
    end
  end

  describe "day 2 - part 2" do
    test "can move in all directions on the fu keypad" do
      assert move(:fu, "R", "2") == "3"
      assert move(:fu, "D", "4") == "8"
      assert move(:fu, "L", "C") == "B"
      assert move(:fu, "U", "A") == "6"
    end

    test "cannot move outside of the fu keypad" do
      assert move(:fu, "U", "1") == "1"
      assert move(:fu, "R", "9") == "9"
      assert move(:fu, "D", "D") == "D"
      assert move(:fu, "L", "5") == "5"
    end

    test "can find the next valid key on the fu keypad" do
      assert get_next_key(:fu, "ULL", []) == "5"
      assert get_next_key(:fu, "RRDDD", ["5"]) == "D"
      assert get_next_key(:fu, "LURDL", ["5", "D"]) == "B"
      assert get_next_key(:fu, "UUUUD", ["5", "D", "B"]) == "3"
    end

    test "can find the bathroom code on the fu keypad" do
      instructions = """
      ULL
      RRDDD
      LURDL
      UUUUD
      """

      assert get_bathroom_code(instructions, [keypad_type: :fu]) == "5DB3"
    end

    test "can solve day 2 - part 2" do
      answer =
        File.read!("test/day2/day2.txt")
        |> get_bathroom_code([keypad_type: :fu])

        IO.puts "day 2 - part 2: #{answer}"
    end
  end
end
