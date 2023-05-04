
require 'socket'

def llamada_client ()
    begin 
        puts "Introduce el puerto para hacer transaciones:"
        port = gets.chomp.to_i # pongo el to_i para pasarlo a numero


        # Imprimir los datos introducidos por el usuario
        puts "El puerto es #{port}"

        socket = TCPSocket.new('localhost', "#{port}")

        socket.write("Funciona bien\n")
        puts socket.gets

    rescue
        puts "Se ha producido un error: #{error.message}"
    end
    socket.close
end