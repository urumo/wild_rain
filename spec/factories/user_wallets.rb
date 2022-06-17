# frozen_string_literal: true

FactoryBot.define do
  factory :user_wallet do
    available { '9.99' }
    user { build :user }
  end
end
