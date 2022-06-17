# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'HealthChecks', type: :request do
  describe 'GET /status' do
    it 'returns http success' do
      get '/health_check/status'
      expect(response).to have_http_status(:success)
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:is_up]).to be(true)
    end
  end
end
