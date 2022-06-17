# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UserWallets', type: :request do
  before :each do
    @user = create :user
    @wallet = @user.wallet
  end

  describe 'GET /available' do
    it 'returns http success' do
      get '/user_wallet/available', params: {}, headers: { 'Authorization' => @user.id }
      expect(response).to have_http_status(:success)
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:available].to_f).to be 0.0
    end
  end
end
