# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :classroom do
    website "MyString"
    location "MyString"
    School nil
    notes "MyText"
  end
end
