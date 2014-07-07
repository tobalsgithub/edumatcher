require 'rails_helper'

RSpec.describe GradeLevel, :type => :model do

  describe 'basic validation checks' do
    it { should have_many(:classrooms) }
    it { should validate_presence_of(:name)}
  end
end
