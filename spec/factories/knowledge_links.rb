# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :expert_knowledge_link, class: :knowledge_link do
    subject
    association :knowledgeable, :factory => :expert
  end
  factory :classroom_knowledge_link, class: :knowledge_link do
    subject
    association :knowledgeable, :factory => :classroom
  end
end
