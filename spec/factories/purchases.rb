# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :purchase do
    user_id 1
    ship_name Faker::Name.name
    ship_address Faker::Address.city
    ship_zip_code Faker::Number.number(7)
    delivery_time :t_8_12
    delivery_date 1.day.from_now.to_date
    product_price 1000
    shipping_cost 600
    cash_on_delivery 300
    tax_percentage 8
  end
end
