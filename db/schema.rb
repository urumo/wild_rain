# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_220_617_222_205) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'pgcrypto'
  enable_extension 'plpgsql'

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum 'transaction_type', %w[sender receiver]

  create_table 'transactions', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'sender_id', null: false
    t.uuid 'receiver_id', null: false
    t.decimal 'amount', precision: 32, scale: 8
    t.decimal 'sender_had', precision: 32, scale: 8
    t.decimal 'sender_has', precision: 32, scale: 8
    t.decimal 'receiver_had', precision: 32, scale: 8
    t.decimal 'receiver_has', precision: 32, scale: 8
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['receiver_id'], name: 'index_transactions_on_receiver_id'
    t.index ['sender_id'], name: 'index_transactions_on_sender_id'
  end

  create_table 'user_wallets', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.decimal 'available', precision: 32, scale: 8
    t.uuid 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_user_wallets_on_user_id'
  end

  create_table 'users', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'email'
    t.string 'password_digest'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
  end

  add_foreign_key 'transactions', 'users', column: 'receiver_id'
  add_foreign_key 'transactions', 'users', column: 'sender_id'
  add_foreign_key 'user_wallets', 'users'
end
