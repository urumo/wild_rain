# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserWallet, type: :model do
  setup do
    user = create :user
    @wallet = create :user_wallet, user:
  end
  describe 'wallet' do
    it 'should contain money' do
      expect(@wallet.available).to be > 0
    end
  end
end
