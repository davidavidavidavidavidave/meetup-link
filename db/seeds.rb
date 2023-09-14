# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
# #   Character.create(name: "Luke", movie: movies.first)
# # require 'faker'

User.destroy_all
puts "Users deleted"
Meetup.destroy_all
puts "Meetups deleted"
puts "Generating users...."

User.create!(
  username: "Tom",
  email: "User1@email.com",
  password: "123456",
  address: "36 Howberry Road, Thornton Heath, CR7 8HY"
)

User.create!(
  username: "Cat",
  email: "User2@email.com",
  password: "123456",
  address: "77 Eaton Rise, London W5 2HE"
)

User.create!(
  username: "Raf",
  email: "User3@email.com",
  password: "123456",
  address: "12 Oak Grove, London NW2 3LP"
)
puts "Users created"

User.create!(
  username: "Dave",
  email: "User4@email.com",
  password: "123456",
  address: "90 Roding Road E5 0DS, UK"
)
puts "User created"

puts "Sorting geocoder coordinates...."

addresses = ["36 Howberry Road, Thornton Heath, CR7 8HY",
             "77 Eaton Rise, London, W5 2HE",
             "12 Oak Grove, London, NW2 3LP",
             "90 Roding Road, E5 0DS, UK",
             "88 Moncrieff Street, London, SE15 5HL"]

puts "These are the addresses: "
p addresses

coordinates = addresses.map do |address|
  result = Geocoder.coordinates(address)
  [result[0], result[1]]
end

puts "These are the coordinates: "
p coordinates

centre = Geocoder::Calculations.geographic_center(coordinates)

puts "This is the centre point: "
p centre

puts "Geocoding completed"

puts "Generating meetup....."

Meetup.create!(
  id: 1,
  user_id: 1,
  name: "Dave_Tom_Raf_Work_Party",
  location: "We Work office space, 21 Soho Square, London W1D 3QP",
  event_date: Date.new(2023, 9, 30),
  purpose: "Work!",
  passcode: "£123456£",
  centre_point_test: centre
)

puts "Meetup created"


puts "Generating user_meetup....."

UserMeetup.create!(
  user_id: 1,
  meetup_id: 1
)

UserMeetup.create!(
  user_id: 2,
  meetup_id: 1
)

UserMeetup.create!(
  user_id: 3,
  meetup_id: 1
)

UserMeetup.create!(
  user_id: 4,
  meetup_id: 1
)

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
