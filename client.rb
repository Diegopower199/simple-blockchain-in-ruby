
require 'socket'
require './blockchain.rb'


    begin 
        socket = TCPSocket.new('localhost', 3000)
        puts socket
        socket.write("Funciona bien la llamada al cliente\n")
        puts socket.gets

        launcher

    rescue
        puts "Se ha producido un error: #{error.message}"
    end
    socket.close
