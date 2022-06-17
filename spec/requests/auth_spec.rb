# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Auths', type: :request do
  let(:user_params) { { email: 't1@email.com', password: 'T1Password' } }
  before :each do
    User.create(user_params)
  end
  describe 'post /sign_up' do
    it 'returns http success' do
      post '/auth/sign_up', params: { email: 'test@email.com', password: 'Password1' }.as_json
      expect(response).to have_http_status(:success)
    end

    it 'should fail if email is not present' do
      post '/auth/sign_up', params: { email: 'test@email.com' }.as_json
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'should fail if password is not present' do
      post '/auth/sign_up', params: { password: 'Password1' }.as_json
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'post /sign_in' do
    it 'returns http success and user id' do
      post '/auth/sign_in', params: { email: 't1@email.com', password: 'T1Password' }.as_json
      expect(response).to have_http_status(:success)
    end
    it 'returns should fail if email is incorrect' do
      post '/auth/sign_in', params: { email: 'something', password: 'also something' }
      expect(response).to have_http_status(:not_found)
    end
    it 'returns should fail if password is incorrect' do
      post '/auth/sign_in', params: { email: 't1@email.com', password: 'also something' }
      expect(response).to have_http_status(:bad_request)
    end
  end
end
