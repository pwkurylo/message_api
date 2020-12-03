class MessageDecryptService
  include Encrypt
  attr_reader :id

  def initialize(params)
    @id = params[:id]
  end

  def self.call(params)
    new(params).call
  end

  def call
    find_message
  end

  private

  def find_message
    finded_messagee = Message.find_by(uniq_key: id)
    return message_not_found if finded_messagee.nil?
    return message_already_was_read if finded_messagee.read_at
  
    decrypt_input_message(finded_messagee)
  end

  def decrypt_input_message(finded_messagee)
    finded_messagee.read
    decrypt_message = decrypt(ENV['ENCRYPT_KEY'], finded_messagee.message)
    success_message(decrypt_message, finded_messagee.password)
  end

  def success_message(decrypt_message, password)
    { 
      data: {
        message: decrypt_message,
        password: password
      },
      status: 200
    }
  end

  def message_already_was_read
    {
      error: 'You already requasted this message',
      status: 404
    }
  end

  def message_not_found
    {
      error: 'Message not found',
      status: 404
    }
  end
end