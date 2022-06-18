# frozen_string_literal: true

class CreateUserWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :user_wallets, id: :uuid do |t|
      t.decimal :available, precision: 32, scale: 8
      t.belongs_to :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
