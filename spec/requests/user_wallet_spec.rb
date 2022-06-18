# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'user_wallet', type: :request do
  before :each do
    @user = create :user
    @user2 = create :user, email: 'temp@email.com'
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

  describe 'GET /transactions' do
    it 'should have empty transactions array' do
      get '/user_wallet/transactions', params: {}, headers: { 'Authorization' => @user.id }
      expect(response).to have_http_status(:success)
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:result][:transactions].count).to be 0
    end

    it 'should not have empty transactions array if there are transactions and balance should update' do
      @wallet.update(available: 50)
      create :transaction, sender: @user, receiver: @user2
      get '/user_wallet/transactions', params: {}, headers: { 'Authorization' => @user.id }
      expect(response).to have_http_status(:success)
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:result][:transactions].count).to be 1
      expect(body[:result][:had].to_f).to be 50.0
      expect(body[:result][:has].to_f).to be 40.0
    end
  end
  path '/user_wallet/available' do
    get('available user_wallet') do
      security [api_key: '']
      produces 'application/json'

      response(200, 'successful') do
        schema type: :object,
               properties: {
                 available: { type: :string }
               }
        run_test!
      end
      response(401, 'unauthorized') do
        schema type: :object,
               properties: {
                 message: { type: :string }
               }
        run_test!
      end
    end
  end

  path '/user_wallet/transactions' do
    get('transactions user_wallet') do
      security [api_key: '']
      produces 'application/json'
      response(200, 'successful') do
        schema '$ref' => '#/components/schemas/transactions'
        run_test!
      end
      response(401, 'unauthorized') do
        schema type: :object,
               properties: {
                 message: { type: :string }
               }
        run_test!
      end
    end
  end
end
