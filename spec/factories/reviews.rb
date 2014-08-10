# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :review do
    rating 1
    title "MyString"
    notes "MyString"
    user
    association :reviewable, :factory => :expert
  end
end
