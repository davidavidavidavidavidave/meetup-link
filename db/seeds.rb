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
  username: "Cat",
  email: "User2@email.com",
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

puts "#{User.count} users created"

puts "\n"
puts "==================================="
puts "\n"

puts "Sorting geocoder coordinates...."

addresses = ["36 Howberry Road, Thornton Heath, CR7 8HY",
             "77 Eaton Rise, London, W5 2HE",
             "12 Oak Grove, London, NW2 3LP",
             "90 Roding Road, E5 0DS, UK",
             "88 Moncrieff Street, London, SE15 5HL"]

puts "These are the addresses: #{addresses}"

coordinates = addresses.map do |address|
  result = Geocoder.coordinates(address)
  [result[0], result[1]]
end
puts "These are the coordinates: #{coordinates}"

centre = Geocoder::Calculations.geographic_center(coordinates)
puts "This is the centre point: #{centre}"
puts "Geocoding completed"

puts "\n"
puts "==================================="
puts "\n"

puts "Generating meetup....."

meetup_1 = Meetup.create!(
  id: 1,
  user_id: User.first.id,
  name: "Dave_Tom_Raf_Work_Party",
  location: "TBC",
  event_date: Date.new(2023, 9, 30),
  purpose: "Munch!",
  passcode: "£123456£",
  centre_point_array: centre
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
  user_id: user_2.id,
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

puts "#{UserMeetup.count} UserMeetups created"

puts "\n"
puts "==================================="
puts "\n"

# Chatroom.create!(
#   name: "Dave_Tom_Raf_Work_Party"
# )
# puts "Generating venues...."


# # Venue.create!(
# #   # name: ,
# #   # location:
# #   # type:
# # )
# # puts "Venue created - #{Venue.name}"

# # Venue.create!(
# #   # name: ,
# #   # location:
# #   # type:
# # )
# # puts "Venue created - #{Venue.name}"
