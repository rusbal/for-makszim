class ApplicationController < ActionController::API
  include Knock::Authenticable
  undef_method :current_user

  def success
    render json: { status: 'success' }
  end

  def failure
    render json: { status: 'failed' }, status: :unprocessable_entity
  end
end
