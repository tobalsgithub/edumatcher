# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rating do
    rating 1
    title "MyString"
    notes "MyString"
    user
    association :ratable, :factory => :expert
  end
end
