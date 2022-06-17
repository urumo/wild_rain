# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password :password

  validates :password_digest, length: { minimum: 8 }
  validates_presence_of :password_digest
  validates_presence_of :email
  validates_uniqueness_of :email
end
