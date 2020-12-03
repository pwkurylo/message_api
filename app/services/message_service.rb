class MessageService
  attr_reader :message, :password, :http_origin

  def initialize(params)
    @message     = params[:message]
    @password    = params[:password] || false
    @http_origin = params[:http_origin]
  end

  def self.call(params)
    new(params).call
  end

  def call
    create_message
  end

  private

  def create_message
    new_message = Message.new(message: message, password: password)
    return handle_errors(new_message) unless new_message.save

    create_url(new_message.uniq_key)
  end 

  def handle_errors(new_message)
    errors = new_message.errors.messages.map do |field, errors|
              "#{field}: #{errors.join(', ')}"
            end
    { errors: errors, status: 422 } 
  end

  def create_url(uniq_key)
    message_url = "#{http_origin}/id/#{uniq_key}"
    { message_url: message_url, status: 201 }
  end
end