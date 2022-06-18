# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  setup do
    @user = create :user
    @user2 = create :user, email: 'temp@email.com'
    @wallet = @user.wallet
  end

  describe 'implementation' do
    it 'should raise an error if balance is 0' do
      expect { create(:transaction, sender: @user, receiver: @user2) }.to raise_error(NotEnoughFunds)
    end

    it 'should change user balance after successfully committed' do
      @wallet.update(available: 50)
      create(:transaction, sender: @user, receiver: @user2)
      expect(@wallet.available.to_f).to be 40.0
    end

    it 'should raise an error if balance less then transaction amount' do
      @wallet.update(available: 50)
      expect { create(:transaction, sender: @user, receiver: @user2, amount: 55.0) }.to raise_error(NotEnoughFunds)
    end
  end
end
