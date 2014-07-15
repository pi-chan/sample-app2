# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :diary_image do
    user_id 1
    image "sample.png"
  end
end
