defmodule AdventOfCode2016.InternetProtocolVersion7Test do
  use ExUnit.Case, async: true
  doctest AdventOfCode2016.InternetProtocolVersion7

  import AdventOfCode2016.InternetProtocolVersion7

  describe "day 7 - part 1" do
    test "can parse an ipv7" do
      assert parse_ipv7("abba[mnop]qrst") == ["abba", "mnop", "qrst"]
      assert parse_ipv7("abcd[bddb]xyyx") == ["abcd", "bddb", "xyyx"]
      assert parse_ipv7("aaaa[qwer]tyui") == ["aaaa", "qwer", "tyui"]
      assert parse_ipv7("ioxxoj[asdfgh]zxcvbn") == ["ioxxoj", "asdfgh", "zxcvbn"]
    end

    test "can determine if a sub sequence of an ipv7 contains an abba" do
      assert contains_an_abba?(["a", "b", "b", "a"]) == true
      assert contains_an_abba?(["m", "n", "o", "p"]) == false
      assert contains_an_abba?(["q", "r", "s", "t"]) == false
      assert contains_an_abba?(["i", "o", "x", "x", "o", "j"]) == true
      assert contains_an_abba?(["a", "s", "d", "f", "g", "h"]) == false
      assert contains_an_abba?(["z", "x", "c", "v", "b", "n"]) == false
    end

    test "can determine if an ipv7 supports tls" do
      assert is_supporting_tls?("abba[mnop]qrst") == true
      assert is_supporting_tls?("abcd[bddb]xyyx") == false
      assert is_supporting_tls?("aaaa[qwer]tyui") == false
      assert is_supporting_tls?("ioxxoj[asdfgh]zxcvbn") == true
    end

    test "can count the number of ipv7s supporting tls in a list" do
      input = """
      abba[mnop]qrst
      abcd[bddb]xyyx
      aaaa[qwer]tyui
      ioxxoj[asdfgh]zxcvbn
      """

      assert count_ipv7s_supporting_tls(input) == 2
    end

    test "can solve the day 7 - part 1" do
      answer =
        File.read!("test/day7/day7.txt")
        |> count_ipv7s_supporting_tls

        IO.puts "day 7 - part 1: #{inspect answer}"
    end
  end

  describe "day 7 - part 2" do
    test "can extract alternating patterns" do
      assert extract_alternating_patterns(["a", "b", "a"], []) == [{"a", "b", "a"}]
      assert extract_alternating_patterns(["x", "y", "z"], [{"a", "b", "a"}]) == [{"a", "b", "a"}]
      assert extract_alternating_patterns(["a", "a", "a"], []) == []
      assert extract_alternating_patterns(["z", "a", "z", "b", "z"], []) == [{"z", "b", "z"}, {"z", "a", "z"}]
    end

    test "can search for bab patterns" do
      assert search_bab_patterns({"a", "b", "a"}, [{"b", "a", "b"}], false) == true
      assert search_bab_patterns({"x", "y", "x"}, [{"x", "y", "x"}], false) == false
    end

    test "can determine if an ipv7 supports ssl" do
      assert is_supporting_ssl?("aba[bab]xyz") == true
      assert is_supporting_ssl?("xyx[xyx]xyx") == false
      assert is_supporting_ssl?("aaa[kek]eke") == true
      assert is_supporting_ssl?("zazbz[bzb]cdb") == true
    end

    test "can count the number of ipv7s supporting ssl in a list" do
      input = """
      aba[bab]xyz
      xyx[xyx]xyx
      aaa[kek]eke
      zazbz[bzb]cdb
      """

      assert count_ipv7s_supporting_ssl(input) == 3
    end

    test "can solve the day 7 - part 1" do
      answer =
        File.read!("test/day7/day7.txt")
        |> count_ipv7s_supporting_ssl

        IO.puts "day 7 - part 2: #{inspect answer}"
    end
  end
end
