# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :expert_user, :class => User do
    sequence(:name) { |n| "Expert User #{n}"}
    expert { FactoryGirl.create(:expert) }
    email "expert@gmail.com"
  end
  factory :educator_user, :class => User do
    sequence(:name) { |n| "Educator User #{n}"}
    expert { FactoryGirl.create(:educator) }
    email "educator@gmail.com"
  end
end
