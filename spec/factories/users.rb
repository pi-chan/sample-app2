# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@factory.com"
  end
  
  factory :user do
    email 
    password "password"
    confirmed_at Time.now
    name "name"
  end
end
