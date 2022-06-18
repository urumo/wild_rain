# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    sender { nil }
    receiver { nil }
    amount { '9.99' }
    sender_had { '9.99' }
    sender_has { '9.99' }
    receiver_had { '9.99' }
    receiver_has { '9.99' }
  end
end
