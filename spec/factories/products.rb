# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
    name Faker::Commerce.product_name
    image "sample.png"
    price Faker::Number.number(4)
    description Faker::Lorem.paragraphs.map{|p| "<p>#{p}</p>"}.join("\n")
    hidden false
    display_order 0
  end
end
