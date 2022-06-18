# frozen_string_literal: true

class NotEnoughFunds < StandardError; end

class Transaction < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  before_create :check_sender_balance

  after_create :adjust_sender_and_receiver

  private

  def check_sender_balance
    raise NotEnoughFunds if sender.wallet.available.to_f < amount.to_f
  end

  def adjust_sender_and_receiver
    sender_balance = sender.wallet.available
    receiver_balance = receiver.wallet.available
    update(
      sender_had: sender_balance,
      receiver_had: receiver_balance,
      sender_has: sender_balance - amount,
      receiver_has: receiver_balance + amount
    )

    sender&.wallet&.update(available: sender_has)
    receiver&.wallet&.update(available: receiver_has)
  end
end
