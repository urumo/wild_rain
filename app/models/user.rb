# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password :password
  has_one :wallet, class_name: 'UserWallet', dependent: :destroy
  has_many :sent, class_name: 'Transaction', foreign_key: :sender_id
  has_many :received, class_name: 'Transaction', foreign_key: :receiver_id

  validates :password_digest, length: { minimum: 8 }
  validates_presence_of :password_digest
  validates_presence_of :email
  validates_uniqueness_of :email

  after_create do
    UserWallet.create(available: 0.0, user: self)
  end

  def transactions(dates)
    start_time = dates[:start_time] || Time.now.beginning_of_month
    to_time = dates[:to_time] || Time.now
    start_time = to_time.beginning_of_month if to_time < start_time

    trs = User.transactions(id, start_time, to_time).map { |tr| TransactionByUser.new(*tr.values) }

    {
      had: trs.first&.current_user_had,
      has: trs.last&.current_user_has,
      transactions: trs
    }
  end

  def self.transactions(user_id, start_time, to_time)
    ApplicationRecord.fetch_sp(
      'select * from transactions_by_user(?, ?, ?)',
      user_id, start_time, to_time
    )
  end
end
