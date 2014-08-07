require 'rails_helper'

RSpec.describe Subject, :type => :model do
  describe 'basic validation checks' do
    it { should validate_presence_of(:name) }
    it { should have_many(:knowledge_links) }
    it { should have_many(:experts).through(:knowledge_links) }
    it { should have_many(:classrooms).through(:knowledge_links) }
  end

end
