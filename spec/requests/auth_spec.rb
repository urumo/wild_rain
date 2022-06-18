# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'auth', type: :request do
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

    path '/auth/sign_up' do
      post('sign_up auth') do
        parameter name: :user, in: :body, schema: {
          type: :object,
          properties: {
            email: { type: :string },
            password: { type: :string }
          },
          required: %w[email password]
        }
        consumes 'application/json'
        produces 'application/json'
        response(200, 'success') do
          schema type: :object,
                 properties: {
                   message: { type: :string }
                 }
          let(:email) { 'test@email.com' }
          let(:password) { 'Password1' }
          run_test!
        end
        response(422, 'unprocessable entity') do
          schema type: :object,
                 properties: {
                   message: { type: :object }
                 }
          let(:password) { 'Password1' }
          run_test!
        end
      end
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

    path '/auth/sign_in' do
      post('sign_in auth') do
        parameter name: :user, in: :body, schema: {
          type: :object,
          properties: {
            email: { type: :string },
            password: { type: :string }
          },
          required: %w[email password]
        }
        consumes 'application/json'
        produces 'application/json'

        response(200, 'success') do
          schema type: :object,
                 properties: {
                   message: { type: :string },
                   user_id: { type: :string }
                 }
          let(:email) { 't1@email.com' }
          let(:password) { 'T1Password' }
          run_test!
        end

        response(404, 'not found') do
          schema type: :object,
                 properties: {
                   message: { type: :string }
                 }
          let(:email) { 'unknown' }
          let(:password) { 'unknown' }
          run_test!
        end

        response(400, 'bad request') do
          schema type: :object,
                 properties: {
                   message: { type: :string }
                 }
          let(:email) { 't1@email.com' }
          let(:password) { 'unknown' }
          run_test!
        end
      end
    end
  end
end
