# frozen_string_literal: true

class UserWalletController < ApplicationController
  before_action :authenticate

  def available
    render json: { available: current_wallet&.available }
  rescue StandardError
    render json: { message: 'something went wrong' }
  end

  def transactions
    from = begin
      params[:from].to_datetime
    rescue StandardError
      nil
    end
    to = begin
      params[:to].to_datetime
    rescue StandardError
      nil
    end

    dates = {
      start_time: from,
      to_time: to
    }.compact_blank

    result = @current_user.transactions(dates)

    render json: { message: 'success', result: }
  end

  private

  def current_wallet = @current_user&.wallet
end
