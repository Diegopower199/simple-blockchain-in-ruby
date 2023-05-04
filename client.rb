
require 'socket'

def llamada_client ()
    begin 
        socket = TCPSocket.new('localhost', 3000)

        socket.write("Funciona bien la llamada al cliente\n")
        puts socket.gets

    rescue
        puts "Se ha producido un error: #{error.message}"
    end
    socket.close
end