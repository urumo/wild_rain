# frozen_string_literal: true

class UserWallet < ApplicationRecord
  belongs_to :user
end
