
require 'socket'

server = TCPServer.new('localhost', 3000)

$stdout.sync = true

loop do
    client = server.accept

    until client.eof?
        msg = client.gets

        client.write(msg)

    end
end