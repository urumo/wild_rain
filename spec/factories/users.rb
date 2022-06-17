# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'test@email.com' }
    password_digest { 'MySecurePassword1' }
  end
end
