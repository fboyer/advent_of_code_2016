defmodule AdventOfCode2016.HowAboutANiceGameOfChess do
  def generate_password(door_id, opts \\ [char_index: 5, md5_prefix: "00000", password_length: 8]) do
    trimmed_door_id =
      door_id
      |> String.trim

    Stream.iterate(0, &(&1 + 1))
    |> Stream.map(&generate_md5_hash(trimmed_door_id, &1))
    |> Stream.filter(&String.starts_with?(&1, opts[:md5_prefix]))
    |> Stream.map(&String.at(&1, opts[:char_index]))
    |> Stream.take(opts[:password_length])
    |> Enum.join
  end

  def generate_cinematic_password(door_id, opts \\ [char_index: 6, char_pos: 5, md5_prefix: "00000", password_length: 8]) do
    trimmed_door_id =
      door_id
      |> String.trim

    Stream.iterate(0, &(&1 + 1))
    |> Stream.map(&generate_md5_hash(trimmed_door_id, &1))
    |> Stream.filter(&String.starts_with?(&1, opts[:md5_prefix]))
    |> Enum.reduce_while(%{}, &build_cinematic_password(&1, &2, opts))
    |> Map.values
    |> Enum.join
  end

  def build_cinematic_password(hash, password, opts) do
    pos =
      hash
      |> String.at(opts[:char_pos])
      |> String.to_integer(16)

    if pos < opts[:password_length] && Map.has_key?(password, pos) == false do
      new_password = Map.put(password, pos, String.at(hash, opts[:char_index]))
      if map_size(new_password) < opts[:password_length] do
        {:cont, new_password}
      else
        {:halt, new_password}
      end
    else
        {:cont, password}
    end
  end

  def generate_md5_hash(door_id, index) do
    door_id <> Integer.to_string(index)
    |> md5
  end

  def md5(data) do
    data
    |> :erlang.md5
    |> Base.encode16(case: :lower)
  end
end
