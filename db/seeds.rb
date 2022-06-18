# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create(email: 'some_email@dot.com', password: 'SuperSecurePassword')
User.create(email: 'some_email2@dot.com', password: 'SuperSecurePassword')

User.first.wallet.update(available: 230)

Transaction.create(sender: User.first, receiver: User.last, amount: 25)
Transaction.create(sender: User.first, receiver: User.last, amount: 25)
Transaction.create(sender: User.last, receiver: User.first, amount: 5)
Transaction.create(sender: User.first, receiver: User.last, amount: 25)
