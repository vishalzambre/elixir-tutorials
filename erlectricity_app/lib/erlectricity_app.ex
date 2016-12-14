defmodule ErlectricityApp do
  @ruby_echo Application.app_dir(:erlectricity_app, "priv/ruby/sum.rb")

  @command "ruby #{@ruby_echo}"

  def sum_two_integers_in_ruby(one, another) do
    pid = Port.open({:spawn, @command}, [{:packet, 4}, :nouse_stdio, :exit_status, :binary])

    encoded_msg = {:sum_two_integers, one, another} |> encode_data

    pid |> Port.command(encoded_msg)

    receive do
      {_, {:data, data}} ->
      case data |> decode_data do
        {:result, result} -> result
        _ -> {:error, "Unknown message"}
      end
    end
  end

  defp encode_data(data) do
    data |> :erlang.term_to_binary
  end

  defp decode_data(data) do
    data |> :erlang.binary_to_term
  end
end
