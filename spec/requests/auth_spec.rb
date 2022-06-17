# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Auths', type: :request do
  describe 'GET /sign_in' do
    it 'returns http success' do
      post '/auth/sign_in'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /sign_up' do
    it 'returns http success' do
      post '/auth/sign_up'
      expect(response).to have_http_status(:success)
    end
  end
end
