# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :classroom do
    sequence(:name) {|n| "My awesome classroom #{n} " }
    website "http://www.tobaltopia.com"
    location "1208 Villanova Drive, Davis, CA 95616"
    School { FactoryGirl.create(:school) }
    after(:create) { |classroom| classroom.educators = [FactoryGirl.create(:educator)] }
    after(:create) { |classroom| classroom.subjects = [FactoryGirl.create(:subject)] }
    notes "We teach lots of cool stuf here."
  end
end
