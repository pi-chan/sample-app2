# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
    name Faker::Commerce.product_name
    image ActionDispatch::Http::UploadedFile.new(:tempfile => File.new("#{Rails.root}/spec/fixtures/sample.png"), filename: "sample.png")
    price Faker::Number.number(4)
    description Faker::Lorem.paragraphs.map{|p| "<p>#{p}</p>"}.join("\n")
    hidden false
    display_order 0
  end
end
