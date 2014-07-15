# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :purchase_product do
    purchase_id 1
    product_id 1
    version 1
    amount 1
  end
end
