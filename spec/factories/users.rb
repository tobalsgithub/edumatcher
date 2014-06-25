# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    #email "@gmail.com"
    sequence(:email) { |n| "user#{n}@gmail.com" }
    sequence(:password) { |n| "password#{n}" }
    #encrypted_password "asdfasdfasdf"
    #password = "boom"
    #sign_in_count 0
    #failed_attempts 0
  end
  # factory :expert_user, :class => :user do
  #   sequence(:fullname) { |n| "Expert User #{n}"}
  #   #expert { FactoryGirl.create(:expert) }
  #   expert
  #   email "expert@gmail.com"
  # end
  # factory :educator_user, :class => :user do
  #   sequence(:fullname) { |n| "Educator User #{n}"}
  #   educator
  #   email "educator@gmail.com"
  # end
end
