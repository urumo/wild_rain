# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'health_check', type: :request do
  describe 'GET /status' do
    it 'returns http success' do
      get '/health_check/status'
      expect(response).to have_http_status(:success)
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:is_up]).to be(true)
    end

    path '/health_check/status' do
      get('status health_check') do
        produces 'application/json'
        response(200, 'success') do
          schema type: :object,
                 properties: {
                   is_up: { type: :string }
                 }
          run_test!
        end
      end
    end
  end
end
