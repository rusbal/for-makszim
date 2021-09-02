class ApplicationController < ActionController::API
  def success
    render json: { status: 'success' }
  end

  def failure
    render json: { status: 'failed' }, status: :unprocessable_entity
  end
end
