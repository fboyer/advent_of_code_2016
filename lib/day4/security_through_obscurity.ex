defmodule AdventOfCode2016.SecurityThroughObscurity do
  @number_of_letters_in_alphabet 26
  @convert_between_ascii_and_alphabet 96

  def sum_valid_rooms_sector_ids(data) do
    data
    |> String.split("\n", trim: true)
    |> Stream.map(&parse_room/1)
    |> Stream.filter(&is_valid?/1)
    |> Stream.map(fn({_encrypted_name, sector_id, _checksum}) -> sector_id end)
    |> Enum.sum
  end

  def parse_room(room) do
    [encrypted_name, sector_id, checksum] = Regex.run(~r/(.+)-(\d+)\[(.+)\]/, room, capture: :all_but_first)
    {encrypted_name, String.to_integer(sector_id), checksum}
  end

  def is_valid?({encrypted_name, _sector_id, checksum}) do
    calculate_checksum(encrypted_name) == checksum
  end

  def calculate_checksum(encrypted_name) do
    encrypted_name
    |> String.replace("-", "")
    |> String.graphemes
    |> Enum.group_by(&(&1))
    |> Enum.sort_by(fn({k, v}) -> {k, length(v)} end, fn({k1, v1}, {k2, v2}) ->
      cond do
        v1 < v2 -> false
        v1 == v2 && k1 > k2 -> false
        true -> true
      end
    end)
    |> Stream.map(fn({k, _v}) -> k end)
    |> Stream.take(5)
    |> Enum.join
  end

  def find_real_room_name(data, search_term) do
    match =
      data
      |> String.split("\n", trim: true)
      |> Stream.map(&parse_room/1)
      |> Stream.filter(&is_valid?/1)
      |> Stream.map(&decipher_encrypted_name/1)
      |> Enum.find(fn({deciphered_name, _sector_id, _checksum}) ->
        String.contains?(deciphered_name, search_term)
      end)

    case match do
      nil -> nil
      _ -> elem(match, 1)
    end
  end

  def decipher_encrypted_name({encrypted_name, sector_id, checksum}) do
    deciphered_name =
      encrypted_name
      |> String.split("-")
      |> Stream.map(&String.to_charlist/1)
      |> Stream.map(fn(letters) -> rotate_letters_by_sector_id(letters, sector_id) end)
      |> Stream.map(&to_string/1)
      |> Enum.join(" ")

    {deciphered_name, sector_id, checksum}
  end

  def rotate_letters_by_sector_id(letters, sector_id) do
    letters
    |> Stream.map(fn(letter) -> letter - @convert_between_ascii_and_alphabet end)
    |> Stream.map(fn(letter) -> letter + sector_id end)
    |> Stream.map(fn(letter) -> rem(letter, @number_of_letters_in_alphabet) end)
    |> Enum.map(fn(letter) -> letter + @convert_between_ascii_and_alphabet end)
  end
end
