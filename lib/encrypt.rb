module Encrypt
  def aes(type, key, text)
    (aes = OpenSSL::Cipher.new('aes-256-cbc').send(type)).key = Digest::SHA256.digest(key)
    aes.update(text) << aes.final
  end
  
  def encrypt(key, text)
    aes(:encrypt, key, text)
  end
  
  def decrypt(key, text)
    aes(:decrypt, key, text).force_encoding('UTF-8')
  end
end