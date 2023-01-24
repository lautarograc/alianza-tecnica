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

20.times do |i|
    Event.create!(starts: i.even? ? Time.now : Time.now + 1.hour, ends: i.even? ? Time.now + 1.hour : Time.now + 2.hours)
    end
end