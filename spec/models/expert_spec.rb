require 'rails_helper'

RSpec.describe Expert, :type => :model do
  describe 'basic validation checks' do
    it { should belong_to(:user) }
    it { should have_and_belong_to_many(:subjects) }
    it { should have_and_belong_to_many(:companies) }
  end

  describe 'adding and removing subjects' do
    before(:each) do
      @expert = create(:expert)
      @subject = create(:subject)
    end

    it 'can add a subject' do
      @expert.subjects << @subject
      expect(@expert.subjects.count).to be(1)
    end

    it 'can remove a subject' do

    end
  end
end
