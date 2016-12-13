defmodule AdventOfCode2016.SecurityThroughObscurityTest do
  use ExUnit.Case
  doctest AdventOfCode2016.SecurityThroughObscurity

  import AdventOfCode2016.SecurityThroughObscurity

  describe "day 4 - part 1" do
    test "can parse a room" do
      assert parse_room("aaaaa-bbb-z-y-x-123[abxyz]") == {"aaaaa-bbb-z-y-x", 123, "abxyz"}
      assert parse_room("a-b-c-d-e-f-g-h-987[abcde]") == {"a-b-c-d-e-f-g-h", 987, "abcde"}
      assert parse_room("not-a-real-room-404[oarel]") == {"not-a-real-room", 404, "oarel"}
      assert parse_room("totally-real-room-200[decoy]") == {"totally-real-room", 200, "decoy"}
    end

    test "can calculate a checksum" do
      assert calculate_checksum("aaaaa-bbb-z-y-x") == "abxyz"
      assert calculate_checksum("a-b-c-d-e-f-g-h") == "abcde"
      assert calculate_checksum("not-a-real-room") == "oarel"
    end

    test "can validate a room" do
      assert is_valid?({"aaaaa-bbb-z-y-x", 123, "abxyz"}) == true
      assert is_valid?({"a-b-c-d-e-f-g-h", 987, "abcde"}) == true
      assert is_valid?({"not-a-real-room", 404, "oarel"}) == true
      assert is_valid?({"totally-real-room", 200, "decoy"}) == false
      assert is_valid?({"ckgvutofkj-jek-giwaoyozout",	436,	"tsfzu"}) == false
      assert is_valid?({"votubcmf-cjpibabsepvt-qmbtujd-hsbtt-nbobhfnfou", 129, "btfou"}) == true
    end

    test "can sum valid rooms sector ids" do
      input = """
      aaaaa-bbb-z-y-x-123[abxyz]
      a-b-c-d-e-f-g-h-987[abcde]
      not-a-real-room-404[oarel]
      totally-real-room-200[decoy]
      """

      assert sum_valid_rooms_sector_ids(input) == 1514
    end

    test "can solve the day 4 - part 1" do
      answer =
        File.read!("test/day4/day4.txt")
        |> sum_valid_rooms_sector_ids

        IO.puts "day 4 - part 1: #{inspect answer}"
    end
  end

  describe "day 4 - part 2" do
    test "can rotate letters by sector id" do
      assert rotate_letters_by_sector_id('qzmt', 343) == 'very'
      assert rotate_letters_by_sector_id('zixmtkozy', 343) == 'encrypted'
      assert rotate_letters_by_sector_id('ivhz', 343) == 'name'
    end

    test "can decipher encrypted name" do
      assert decipher_encrypted_name({"qzmt-zixmtkozy-ivhz", 343, "zimth"}) == {"very encrypted name", 343, "zimth"}
    end

    test "can search for a term in a real room name" do
      input = """
      qzmt-zixmtkozy-ivhz-343[zimth]
      """

      assert find_real_room_name(input, "very") == 343
      assert find_real_room_name(input, "encrypted") == 343
      assert find_real_room_name(input, "name") == 343
      assert find_real_room_name(input, "notfound") == nil
    end

    test "can solve the day 4 - part 2" do
      answer =
        File.read!("test/day4/day4.txt")
        |> find_real_room_name("northpole")

        IO.puts "day 4 - part 2: #{inspect answer}"
    end
  end
end
