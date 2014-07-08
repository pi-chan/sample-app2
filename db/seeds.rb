# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require "faker"

array = (0..99).to_a.shuffle
array.each do |i|
  image_name = sprintf "image%02d.jpg", i
  product = Product.new(
    name: Faker::Commerce.product_name,
    image: open("#{Rails.root}/db/fixtures/#{image_name}"),
    price: Faker::Number.number( (2..6).to_a.sample ),
    description: Faker::Lorem.paragraphs( (2..5).to_a.sample ).map{|p| "<p>#{p}</p>"}.join("\n"),
    hidden: false,
    display_order: Faker::Number.number( (1..3).to_a.sample )
  )
  product.save
  puts product
end
