# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.find_or_create_by!(email: 'admin@email.com') do |user|
  user.name = 'admin'
  user.password = 'p'
  user.introduction = 'I am admin user'
  user.admin = true
end

(1..30).each do |i|
  User.find_or_create_by!(email: "user#{i}@email.com") do |user|
    user.name = "user#{i}"
    user.password = 'p'
    user.introduction = 'I want to become a great engineer Mom'
    user.admin = false
  end
end

(1..10).each do |i|
Meeting.create!(
  label: "stuff to do #{i}",
  detail: 'foo',
  start_time: Date.today,
  user_id: 1
)
end

(1..10).each do |i|
  Meeting.create!(
    label: "stuff to do #{i}",
    detail: 'foo',
    start_time: Date.today,
    user_id: 2
  )
end