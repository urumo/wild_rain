# frozen_string_literal: true

class HealthCheckController < ApplicationController
  def status
    render json: { is_up: true }
  end
end
