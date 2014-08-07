require 'rails_helper'

RSpec.describe Classroom, :type => :model do
  describe 'basic validation checks' do
    it { should belong_to(:school) }
    it { should validate_presence_of(:name) }
    it { should have_many(:educator_staffings) }
    it { should have_many(:educators).through(:educator_staffings) }
    it { should have_many(:subjects).through(:knowledge_links) }
    it { should have_many(:knowledge_links) }
    it { should validate_presence_of(:school) }
    it { should belong_to(:grade_level) }
  end

  xdescribe 'as_json' do
    it 'should include the school when returned as json' do
      classroom = create(:classroom)
      json = classroom.to_json
      expect(json).to have_key("school")
    end
  end

end
