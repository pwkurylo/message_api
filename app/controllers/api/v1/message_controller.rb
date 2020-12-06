
class Api::V1::MessageController < ActionController::Base
  skip_before_action :verify_authenticity_token

  def show
    result = ::MessageDecryptService.call({ id: params[:id] })
    return render json: result[:data] if result[:status] == 200

    render json: { error: result[:error] }, status: 404
  end
  
  def create
    result = ::MessageService.call(message_params)
    return render json: { message_url: result[:message_url] } if result[:status] == 201

    render json: { errors: result[:errors] }, status: 422
  end

  private

  def message_params
    params.permit(:password, :message).merge(http_origin: request.env['HTTP_ORIGIN'])
  end
end
