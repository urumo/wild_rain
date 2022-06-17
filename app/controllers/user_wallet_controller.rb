# frozen_string_literal: true

class UserWalletController < ApplicationController
  before_action :authenticate

  def available
    render json: { available: current_wallet.available }
  end

  private

  def current_wallet = @current_user.wallet
end
