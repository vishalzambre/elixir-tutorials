defmodule ChatEx do
  use Application

  @process_name :ex_rb
  @ruby_process_name :ruby

  def receive_messages do
    receive do
      {:register, pid} ->
        IO.puts "Ruby connected!"
        Agent.start_link(fn -> pid end, name: @ruby_process_name)
      {:message, message} ->
        IO.puts "Message from ruby: #{message}"
    end
    receive_messages
  end

  def read_line do
    case IO.read(:stdio, :line) do
      :eof -> :ok
      {:error, reason} -> IO.puts "Error: #{reason}"
      data ->
        if Process.registered |> Enum.member?(@ruby_process_name) do
          ruby = Agent.get(@ruby_process_name, &(&1))
          send ruby, data
        end
    end
    read_line
  end

  def start(_type, _args) do
    pid = spawn(&receive_messages/0)
    Process.register(pid, @process_name)
    read_line
  end
end
