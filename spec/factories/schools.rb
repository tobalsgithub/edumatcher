# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :school do
    website "MyString"
    location "MyString"
    SchoolDistrict nil
  end
end
