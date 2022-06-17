# frozen_string_literal: true

class ApplicationController < ActionController::API
  def authenticate
    @current_user = User.find(request.headers['Authorization']) # TODO: Authorization header should contain user ID at the moment, replace with JWT
  rescue StandardError => e
    render text: 'Unauthorized', status: :unauthorized
  end
end
