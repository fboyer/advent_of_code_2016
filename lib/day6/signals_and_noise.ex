defmodule AdventOfCode2016.SignalsAndNoise do
  def error_correct_message(messages, opts \\ [sort: :most_common]) do
    sorter =
      case opts[:sort] do
        :most_common -> &>=/2
        :least_common -> &<=/2
        _ -> raise "sort is not supported"
      end

    messages
    |> String.split("\n", trim: true)
    |> Enum.reduce(%{}, &process_message(&1, &2))
    |> Stream.map(&extract_error_corrected_letters(&1, sorter))
    |> Enum.join
  end

  def extract_error_corrected_letters({_pos, pos_stats}, sorter) do
    pos_stats
    |> Enum.sort_by(fn({letter, pos}) -> {pos, letter} end, sorter)
    |> List.first
    |> elem(0)
  end

  def process_message(message, stats) do
    message
    |> String.graphemes
    |> Stream.with_index
    |> Enum.reduce(stats, &aggregate_stats(&1, &2))
  end

  def aggregate_stats({letter, pos}, stats) do
    Map.update(stats, pos, %{letter => 1}, fn(pos_stats) ->
      Map.update(pos_stats, letter, 1, &(&1 + 1))
    end)
  end
end
