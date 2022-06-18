# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions, id: :uuid do |t|
      t.references :sender, null: false, type: :uuid
      t.references :receiver, null: false, type: :uuid
      t.decimal :amount, precision: 32, scale: 8
      t.decimal :sender_had, precision: 32, scale: 8
      t.decimal :sender_has, precision: 32, scale: 8
      t.decimal :receiver_had, precision: 32, scale: 8
      t.decimal :receiver_has, precision: 32, scale: 8

      t.timestamps
    end
    add_foreign_key :transactions, :users, column: :sender_id, primary_key: :id
    add_foreign_key :transactions, :users, column: :receiver_id, primary_key: :id
  end
end
