require 'openssl'

def encrypt(texto_sin_encriptar, key, iv)
	cipher = OpenSSL::Cipher::AES.new(256, :CBC)
	cipher.encrypt
	cipher.key = key
	cipher.iv = iv
	encrypted = cipher.update(texto_sin_encriptar) + cipher.final
	return encrypted
  end
  
def decrypt(texto_encriptado, key, iv)
	cipher = OpenSSL::Cipher::AES.new(256, :CBC)
	cipher.decrypt
	cipher.key = key
	cipher.iv = iv
	decrypted = cipher.update(texto_encriptado) + cipher.final
	return decrypted
end

def get_transactions_data

	transactions_block ||= []
	blank_transaction = Hash[remitente: "", destinatario: "", what: "", qty: ""]
	loop do
		puts "" 
		puts "Enter your name for the new transaction"
		remitente = gets.chomp
		puts "" 
		puts "What do you want to send ?"
		what = gets.chomp
		puts "" 
		puts "How much quantity ?"
		qty  = gets.chomp
		puts "" 
		puts "Who do you want to send it to ?"
		destinatario = gets.chomp

		# Creamos una clave de encriptación
		key = OpenSSL::Cipher.new('AES-256-CBC').random_key

		# Creamos un vector de inicialización para la encriptación
		iv = OpenSSL::Cipher.new('AES-256-CBC').random_iv


		# Encriptamos los nombres del remitente y del destinatario
		encrypted_remitente = encrypt(remitente, key, iv)
		encrypted_destinatario = encrypt(destinatario, key, iv)

		# Imprimimos los nombres encriptados y la clave y vector de inicialización
		puts "Remitente encriptado: #{encrypted_remitente}"
		puts "Destinatario encriptado: #{encrypted_destinatario}"
		puts "Clave de encriptación: #{key.unpack('H*').first}"
		puts "Vector de inicialización: #{iv.unpack('H*').first}"

		decrypted_remitente = decrypt(encrypted_remitente, key, iv)
		decrypted_destinatario = decrypt(encrypted_destinatario, key, iv)


		puts "Remitente desencriptado: #{decrypted_remitente}"
		puts "Destinatario desencriptado: #{decrypted_destinatario}"


		

		transaction = Hash[remitente: "#{encrypted_remitente}", destinatario: "#{encrypted_destinatario}", 
											 what: "#{what}", qty: "#{qty}"]
		transactions_block << transaction

		puts "" 
		puts "Do you want to make another transaction for this block ? (Y/n)"
		new_transaction = gets.chomp.downcase

		if new_transaction == "y"
			self
		else
			return transactions_block
			break
		end
	end
end