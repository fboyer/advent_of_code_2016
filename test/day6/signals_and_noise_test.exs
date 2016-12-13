defmodule AdventOfCode2016.SignalsAndNoiseTest do
  use ExUnit.Case, async: true
  doctest AdventOfCode2016.SignalsAndNoise

  import AdventOfCode2016.SignalsAndNoise

  describe "day 6 - part 1" do
    test "can aggregate statistics" do
      assert aggregate_stats({"a", 0}, %{}) == %{0 => %{"a" => 1}}
      assert aggregate_stats({"a", 0}, %{0 => %{"a" => 1}}) == %{0 => %{"a" => 2}}
    end

    test "can process a message" do
      assert process_message("abc", %{}) == %{0 => %{"a" => 1}, 1 => %{"b" => 1}, 2 => %{"c" => 1}}
      assert process_message("abc", %{0 => %{"a" => 1}, 1 => %{"b" => 1}, 2 => %{"c" => 1}}) == %{0 => %{"a" => 2}, 1 => %{"b" => 2}, 2 => %{"c" => 2}}
    end

    test "can error correct a message received using a repetition code" do
      input = """
      eedadn
      drvtee
      eandsr
      raavrd
      atevrs
      tsrnev
      sdttsa
      rasrtv
      nssdts
      ntnada
      svetve
      tesnvt
      vntsnd
      vrdear
      dvrsen
      enarar
      """

      assert error_correct_message(input) == "easter"
    end

    test "can solve the day 6 - part 1" do
      answer =
        File.read!("test/day6/day6.txt")
        |> error_correct_message

        IO.puts "day 6 - part 1: #{answer}"
    end
  end

  describe "day 6 - part 2" do
    test "can error correct a message received using a modified repetition code" do
      input = """
      eedadn
      drvtee
      eandsr
      raavrd
      atevrs
      tsrnev
      sdttsa
      rasrtv
      nssdts
      ntnada
      svetve
      tesnvt
      vntsnd
      vrdear
      dvrsen
      enarar
      """

      assert error_correct_message(input, [sort: :least_common]) == "advent"
    end

    test "can solve the day 6 - part 2" do
      answer =
        File.read!("test/day6/day6.txt")
        |> error_correct_message([sort: :least_common])

        IO.puts "day 6 - part 2: #{answer}"
    end
  end
end
