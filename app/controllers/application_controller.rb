# frozen_string_literal: true

class ApplicationController < ActionController::API
  def authenticate
    @current_user = User.find(request.headers['Authorization']) # TODO: replace with JWT
  rescue StandardError => e
    render text: 'Unauthorized', status: :unauthorized
  end
end
