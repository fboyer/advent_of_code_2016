defmodule AdventOfCode2016.InternetProtocolVersion7 do
  def count_ipv7s_supporting_tls(ipv7s) do
    ipv7s
    |> String.split("\n", trim: true)
    |> Stream.filter(&is_supporting_tls?/1)
    |> Enum.count
  end

  def is_supporting_tls?(ipv7) do
    # TODO: Refactor into function
    combined_seqs =
      ipv7
      |> parse_ipv7
      |> Stream.map(&String.graphemes/1)
      |> Enum.map(&contains_an_abba?/1)

    # TODO: Refactor into function
    supernet_seqs_contains_abba =
      combined_seqs
      |> Stream.take_every(2)
      |> Enum.reduce(false, &(&1 || &2))

    # TODO: Refactor into function
    hypernet_seqs_contains_abba =
      combined_seqs
      |> Stream.drop(1)
      |> Stream.take_every(2)
      |> Enum.reduce(false, &(&1 || &2))

      supernet_seqs_contains_abba && !hypernet_seqs_contains_abba
  end

  def contains_an_abba?([c1, c2, c3, c4 | rest]) do
    if c1 != c2 && [c3, c4] == [c2, c1] do
      true
    else
      contains_an_abba?([c2, c3, c4 | rest])
    end
  end
  def contains_an_abba?(_), do: false

  def count_ipv7s_supporting_ssl(ipv7s) do
    ipv7s
    |> String.split("\n", trim: true)
    |> Stream.filter(&is_supporting_ssl?/1)
    |> Enum.count
  end

  def is_supporting_ssl?(ipv7) do
    # TODO: Refactor into function
    combined_seqs =
      ipv7
      |> parse_ipv7
      |> Enum.map(&String.graphemes/1)

    # TODO: Refactor into function
    supernet_seqs_abas =
      combined_seqs
      |> Stream.take_every(2)
      |> Enum.reduce([], &extract_alternating_patterns(&1, &2))

    # TODO: Refactor into function
    hypernet_seqs_babs =
      combined_seqs
      |> Stream.drop(1)
      |> Stream.take_every(2)
      |> Enum.reduce([], &extract_alternating_patterns(&1, &2))

    supernet_seqs_abas
    |> Enum.reduce(false, &search_bab_patterns(&1, hypernet_seqs_babs, &2))
  end

  def extract_alternating_patterns([c1, c2, c3 | rest], acc) do
    if c1 != c2 && c1 == c3 do
      extract_alternating_patterns([c2, c3 | rest], [{c1, c2, c3} | acc])
    else
      extract_alternating_patterns([c2, c3 | rest], acc)
    end
  end
  def extract_alternating_patterns(_, acc), do: acc

  def search_bab_patterns({a, b, a}, babs, acc) do
    found =
      babs
      |> Enum.find_value(fn(bab) -> {b, a, b} == bab end)

    found || acc
  end

  def parse_ipv7(ipv7) do
    ipv7
    |> String.split(["[", "]"])
  end
end
