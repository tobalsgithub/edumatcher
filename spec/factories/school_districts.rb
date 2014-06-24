# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :school_district do
    website "http://www.tobaltopia.com"
    location "3127 Maple Valley Drive, Madison, WI 53719"
    sequence(:name) { |n| "Best school district ever #{n}" }
    after(:create) { |sd| sd.schools = [FactoryGirl.create(:school), FactoryGirl.create(:school)] }
    after(:create) { |sd| sd.educators = [FactoryGirl.create(:educator), FactoryGirl.create(:educator)] }
  end
end
