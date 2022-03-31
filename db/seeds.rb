# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(
  name: Faker::Name.unique.name,
  email: Faker::Internet.unique.email
)

5.times do
  Category.create(
    name: Faker::Color.unique.color_name
  )
end

200.times do
  Bulletin.create(
    title: Faker::Emotion.unique.noun,
    description: Faker::Lorem.unique.paragraph,
    user_id: user.id,
    category_id: Category.all.sample.id,
    state: %w[draft under_moderation published rejected archived].sample
  )
end
