# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'creation' do
    let(:usr) { build :user }
    it 'should be valid' do
      expect(usr.valid?).to be(true)
    end
    it 'should commit to the database' do
      expect(usr.save).to be(true)
    end
    it 'should hash the password after save' do
      u1 = build(:user, email: 'test1@email.com')
      u1.save
      expect(u1.password_digest).to_not be('MySecurePassword1')
    end
  end
end
