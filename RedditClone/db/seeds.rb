# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

5.times do
  User.create(email: "#{Faker::GameOfThrones.character}@gmail.com", password: "password")
end

AUTHOR_IDS = (1..5).to_a
SUB_IDS = Sub.all.to_a.map(&:id)

15.times do
  Sub.create!(title: Faker::Hipster.word, description: Faker::Hipster.sentence, moderator_id: AUTHOR_IDS.sample)
end


30.times do
  post = Post.new(title: Faker::StarWars.character, url: Faker::StarWars.planet,
    content: Faker::StarWars.quote,
    author_id: AUTHOR_IDS.sample)
  post.sub_ids = SUB_IDS.sample([1,3,5,7].sample)
  post.save
end
