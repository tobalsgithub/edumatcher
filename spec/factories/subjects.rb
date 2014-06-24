# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subject do
    sequence(:name) { |n| "Awesome subject #{n}"}
    after(:create) { |subject| subject.experts = [FactoryGirl.create(:expert)] }
    after(:create) { |subject| subject.classrooms = [FactoryGirl.create(:classroom)] }
  end
end
