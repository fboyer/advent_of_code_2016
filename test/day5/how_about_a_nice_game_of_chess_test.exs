defmodule AdventOfCode2016.HowAboutANiceGameOfChessTest do
  use ExUnit.Case
  doctest AdventOfCode2016.HowAboutANiceGameOfChess

  import AdventOfCode2016.HowAboutANiceGameOfChess

  describe "day 5 - part 1" do
    test "can generate the md5 hash" do
      assert md5("abc3231929") == "00000155f8105dff7f56ee10fa9b9abd"
      assert md5("abc5017308") == "000008f82c5b3924a1ecbebf60344e00"
      assert md5("abc5278568") == "00000f9a2c309875e05c5a5d09f1b8c4"
    end

    @tag long_running: true
    test "can generate a password for a door id" do
      assert generate_password("abc") == "18f47a30"
    end

    @tag long_running: true
    test "can solve the day 5 - part 1" do
      answer =
        File.read!("test/day5/day5.txt")
        |> generate_password

        IO.puts "day 5 - part 1: #{answer}"
    end
  end

  describe "day 5 - part 2" do
    @tag long_running: true
    test "can generate a cinematic password for a door id" do
      assert generate_cinematic_password("abc") == "05ace8e3"
    end

    @tag timeout: 120000
    @tag long_running: true
    test "can solve the day 5 - part 2" do
      answer =
        File.read!("test/day5/day5.txt")
        |> generate_cinematic_password

        IO.puts "day 5 - part 2: #{answer}"
    end
  end
end
