class ApplicationController < ActionController::API

  private
  def render_error(message, status_code, error_code=nil)
    message = message.join(', ') << '.' if message.is_a?(Array)

    render json: {
      message: message,
      error_code: error_code,
    }, status: status_code
  end
end
