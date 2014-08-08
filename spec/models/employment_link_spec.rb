require 'rails_helper'

RSpec.describe EmploymentLink, :type => :model do
  describe 'basic validation checks' do
    it { should belong_to(:company) }
    it { should belong_to(:expert)}
    it { should validate_presence_of(:company) }
    it { should validate_presence_of(:expert) }
  end

end
