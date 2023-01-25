# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

20.times do |i|
  Aliada.create!(name: "MyString#{i}")
end
# this way, the first and last 10 events will have overlapped time slots while the other 10 will not
20.times do |i|
  Event.create!(starts: Time.now + i.hours, ends: Time.now + i.hours + 1.hour, type_is: 'service',
                service_id: "MyString#{i}")
end
10.times do |i|
  Event.create!(starts: Time.now + i.hours, ends: Time.now + i.hours + 1.hour, type_is: 'service',
                service_id: "MyString#{20 + i}")
end
