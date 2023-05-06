
require 'socket'

server = TCPServer.new('localhost', 3000)

$stdout.sync = true

loop do
    client = server.accept

    puts "#{client.eof?}"
    until client.eof?
        msg = client.gets

        client.write(msg)
        puts msg
        puts "#{client.eof?}"
    end
end