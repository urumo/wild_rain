# frozen_string_literal: true

TransactionByUser = Struct.new(
  :id, :current_user,
  :sender_id, :receiver_id,
  :amount, :current_user_had,
  :current_user_has, :other_user_had,
  :other_user_has, :transaction_performed_at
)
