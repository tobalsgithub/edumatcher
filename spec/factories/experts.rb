# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :expert do
    notes "I love teaching stuff"
    #User { FactoryGirl.create(:expert_user) }
    #after(:create) {|expert| expert.subjects = [FactoryGirl.create(:subject), FactoryGirl.create(:subject)]}
  end
end
