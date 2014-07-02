# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :school_district do
    website "http://master.tobaltopia.com"
    location "3127 Maple Valley Drive, Madison, WI 53719"
    sequence(:name) { |n| "Best school district ever #{n}" }
  end
end
