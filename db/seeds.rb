# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# require 'faker'

puts "Generating users...."

User.create!(
  email: "User0@email.com",
  password: "123456",
  address: "90 Roding Road E5 0DS, UK"
)
puts "User created - #{User.email}"

User.create!(
  email: "User1@email.com",
  password: "654321",
  address: "3 bawden close, cantebury, CT2 7DW, UK"
)

User.create!(
  email: "User2@email.com",
  password: "654321",
  address: "69a Stoke Newington High St, London N16 8EL, UK"
)


puts "User created - #{User.email}"

puts "Generating venues...."

Venue.create!(
  name: "Central",
  password: "654321",
  address: "69a Stoke Newington High St, London N16 8EL, UK"
)
puts "Venue created - #{Venue.name}"

Venue.create!(
  # name: ,
  # location:
  # type:
)
puts "Venue created - #{Venue.name}"

Venue.create!(
  # name: ,
  # location:
  # type:
)
puts "Venue created - #{Venue.name}"

puts "Generating meetup....."

Meetup.create!(
  # name: ,
  # date: ,
  # location: ,
  # type: ,
  # passcode:
)
