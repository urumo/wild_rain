# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    sender { create :user }
    receiver { create :user, email: 'temp@email.com' }
    amount { '10.0' }
    sender_had {}
    sender_has {}
    receiver_had {}
    receiver_has {}
  end
end
