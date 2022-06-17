# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password :password
  has_one :wallet, class_name: 'UserWallet', dependent: :destroy

  validates :password_digest, length: { minimum: 8 }
  validates_presence_of :password_digest
  validates_presence_of :email
  validates_uniqueness_of :email

  after_create do
    UserWallet.create(available: 0.0, user: self)
  end
end
