# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
# #   Character.create(name: "Luke", movie: movies.first)
# # require 'faker'

UserMeetup.destroy_all
Meetup.destroy_all
User.destroy_all
Message.destroy_all
Chatroom.destroy_all

puts "UserMeetups deleted"
puts "Users deleted"
puts "Meetups deleted"

puts "\n"
puts "==================================="
puts "\n"

puts "Generating users...."

user_1 = User.create!(
  username: "Tom",
  email: "User1@email.com",
  password: "123456",
  address: "36 Howberry Road, Thornton Heath, CR7 8HY"
)

user_2 = User.create!(
  username: "Kat",
  email: "cat@email.com",
  password: "123456",
  address: "77 Eaton Rise, London W5 2HE"
)

user_3 = User.create!(
  username: "Raf",
  email: "User3@email.com",
  password: "123456",
  address: "12 Oak Grove, London NW2 3LP"
)

user_4 = User.create!(
  username: "Dave",
  email: "User4@email.com",
  password: "123456",
  address: "90 Roding Road E5 0DS, UK"
)

user_5 = User.create!(
  username: "Andrew",
  email: "User5@email.com",
  password: "123456",
  address: "3 Esmond Road, London, NW6 7HF"
)

user_6 = User.create!(
  username: "Donesha",
  email: "User6@email.com",
  password: "123456",
  address: "9 Hilldrop Crescent, London, N7 0HX"
)

user_7 = User.create!(
  username: "Doug",
  email: "dog@email.com",
  password: "123456",
  address: "1 Heathfield Road, London, SW18 3HX"
)

user_8 = User.create!(
  username: "Dragos",
  email: "User8@email.com",
  password: "123456",
  address: "10 Elgar Close, London, SE8 4AR"
)

user_9 = User.create!(
  username: "Elizeu",
  email: "User9@email.com",
  password: "123456",
  address: "6 Balfern Grove, London, W4 2JX"
)

user_10 = User.create!(
  username: "Emily",
  email: "User10@email.com",
  password: "123456",
  address: "Flaxman Lodge, Flaxman Terrace, London, WC1H 9AW"
)

user_11 = User.create!(
  username: "Khashayar",
  email: "User11@email.com",
  password: "123456",
  address: "Brodick House, Saxon Road, London, E3 5HJ"
)

user_12 = User.create!(
  username: "Le Wagon",
  email: "User12@email.com",
  password: "123456",
  address: "138 Kingsland Road, London, E2 8DY"
)

user_13 = User.create!(
  username: "Marjan",
  email: "User13@email.com",
  password: "123456",
  address: "21 Third Avenue, Walthamstow, London, E17 9QJ"
)

user_14 = User.create!(
  username: "Meg",
  email: "User14@email.com",
  password: "123456",
  address: "16 Hanley Road, London, N4 3DR"
)

user_15 = User.create!(
  username: "Ryan",
  email: "User15@email.com",
  password: "123456",
  address: "10 Relf Road, London, SE15 4JS"
)

user_16 = User.create!(
  username: "Sinitta",
  email: "User16@email.com",
  password: "123456",
  address: "37 Lavenham Road, London, SW18 5EZ"
)

user_17 = User.create!(
  username: "Priscilla",
  email: "priscilla@email.com",
  password: "123456",
  address: "24 High Street Wimbledon, London SW19 5EA"
)

user_18 = User.create!(
  username: "Khadija",
  email: "Khadija@email.com",
  password: "123456",
  address: "90 Dartford Rd, Dartford DA1 3ER"
)

user_19 = User.create!(
  username: "Anam",
  email: "Anam@email.com",
  password: "123456",
  address: "685 High Rd, London N12 0DA"
)

puts "#{User.count} users created"

puts "\n"
puts "==================================="
puts "\n"

puts "Generating meetup....."

meetup_1 = Meetup.create!(
  user_id: User.first.id,
  name: "Remote workers lunch",
  location: "TBC",
  event_date: Date.new(2023, 9, 30),
  purpose: "Munch!",
  passcode: "98521",
)

puts "#{Meetup.count} UserMeetups created"

puts "\n"
puts "==================================="
puts "\n"


puts "Generating user_meetup....."

UserMeetup.create!(
  user_id: user_1.id,
  meetup_id: meetup_1.id
)

UserMeetup.create!(
  user_id: user_13.id,
  meetup_id: meetup_1.id
)

UserMeetup.create!(
  user_id: user_3.id,
  meetup_id: meetup_1.id
)

UserMeetup.create!(
  user_id: user_4.id,
  meetup_id: meetup_1.id
)

UserMeetup.create!(
  user_id: user_6.id,
  meetup_id: meetup_1.id
)

UserMeetup.create!(
  user_id: user_10.id,
  meetup_id: meetup_1.id
)

UserMeetup.create!(
  user_id: user_11.id,
  meetup_id: meetup_1.id
)

UserMeetup.create!(
  user_id: user_15.id,
  meetup_id: meetup_1.id
)

UserMeetup.create!(
  user_id: user_16.id,
  meetup_id: meetup_1.id
)

UserMeetup.create!(
  user_id: user_9.id,
  meetup_id: meetup_1.id
)

UserMeetup.create!(
  user_id: user_8.id,
  meetup_id: meetup_1.id
)

puts "#{UserMeetup.count} UserMeetups created"
