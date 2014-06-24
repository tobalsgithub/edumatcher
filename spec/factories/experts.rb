# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :expert do
    notes "I love teaching stuff"
    User { FactoryGirl.create(:user) }
    after(:create) {|expert| expert.subjects = [FactoryGirl.create(:subject), FactoryGirl.create(:subject)]}
  end
end
