#!/usr/bin/ruby
require 'bundler'
Bundler.require

COOKIE = 'cookie'
HOST = `hostname -s`.strip
NODE_NAME = 'ruby'
DST_NODE_NAME = 'elixir'
DST_NODE = "#{DST_NODE_NAME}@#{HOST}"
DST_PROC = 'ex_rb'

Erlix::Node.init(NODE_NAME, COOKIE)

connection = Erlix::Connection.new(DST_NODE)

puts "Connected to #{DST_NODE}"

connection.esend(
  DST_PROC,
  Erlix::Tuple.new([
    Erlix::Atom.new("register"),
    Erlix::Pid.new(connection)
  ])
)

Thread.new do
  while true do
    message = connection.erecv
    puts "Message from elixir: #{message.message.data}"
  end
end

while true
  input = STDIN.gets
  connection.esend(
    DST_PROC,
    Erlix::Tuple.new([
      Erlix::Atom.new("message"),
      Erlix::Atom.new(input)
    ])
  )
end
