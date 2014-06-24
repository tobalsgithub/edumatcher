# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :educator do
    notes "I'm a cool teacher"
    User { FactoryGirl.create(:user) }
    after(:create) { |expert| expert.classrooms = [FactoryGirl.create(:classroom), FactoryGirl.create(:classroom)] }
    after(:create) { |expert| expert.schools = [FactoryGirl.create(:school)] }
    after(:create) { |expert| expert.school_disctricts = [FactoryGirl.create(:school_district)] }
  end
end
