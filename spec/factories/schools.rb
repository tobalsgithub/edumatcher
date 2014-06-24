# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :school do
    website "http://math.tobaltopia.com"
    location "21 Arial Circle, Madison, WI 53719"
    sequence(:name) { |n| "Best place to learn things #{n}" }
    SchoolDistrict { FactoryGirl.create(:SchoolDistrict) }
    after(:create) { |school| school.classrooms = [FactoryGirl.create(:classroom), FactoryGirl.create(:classroom)] }
    after(:create) { |school| school.educators = [FactoryGirl.create(:educator), FactoryGirl.create(:educator)] }
  end
end
