require 'rails_helper'

RSpec.describe Expert, :type => :model do
  describe 'basic validation checks' do
    it { should belong_to(:user) }
    it { should have_many(:knowledge_links) }
    it { should have_many(:subjects).through(:knowledge_links) }
    it { should have_many(:employment_links) }
    it { should have_many(:companies).through(:employment_links) }
    it { should have_many(:reviews) }
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
