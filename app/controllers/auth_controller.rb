# frozen_string_literal: true

class AuthController < ApplicationController
  def sign_in
    user = begin
      User.find_by_email(params[:email])
    rescue StandardError
      nil
    end
    return render json: { message: 'User with such email is not found' }, status: :not_found if user.nil?

    is_authenticated = user.authenticate(params[:password])

    return render json: { message: :success, user_id: is_authenticated.id } if is_authenticated

    render json: { message: 'Password incorrect' }, status: :bad_request
  end

  def sign_up
    user = User.new(email: params[:email], password: params[:password])
    return render json: { message: 'Successfully registered' } if user.save

    render json: { message: user.errors.as_json }, status: :unprocessable_entity
  end
end
