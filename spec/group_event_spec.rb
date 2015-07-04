require 'rails_helper'

RSpec.describe GroupEvent, type: :model do
  describe '#has_no_blank_fields?' do
    it 'returns true if instance has no blank fields' do
      @group_event = FactoryGirl.create(:group_event)

      expect(@group_event.has_no_blank_fields?).to be_truthy
    end

    it 'returns false if instance has at least one blank field' do
      @group_event = FactoryGirl.create(:group_event, user_id: nil)

      expect(@group_event.has_no_blank_fields?).to be_falsey
    end
  end

  describe '#set_ends_at' do
    it 'sets :ends_at if it is nil and :duration and :starts_at are given' do
      @group_event = FactoryGirl.create(:group_event, starts_at: Date.today, duration: 10, ends_at: nil)
      expect(@group_event.ends_at).to eq(Date.today + 10.days)
    end
  end

  describe '#set_duration' do
    it 'sets :duration if it is nil and :ends_at and :starts_at are given' do
      @group_event = FactoryGirl.create(:group_event, starts_at: Date.today, duration: nil, ends_at: Date.today + 10.days)
      expect(@group_event.duration).to eq(10)
    end
  end

  describe '#set_formatted_description' do
    it 'sets :formatted_description' do
      @group_event = FactoryGirl.create(:group_event, original_description: 'Test Test Test')
      expect(@group_event.formatted_description).to eq("<p>Test Test Test</p>\n")
    end

    it 'changes :formatted_description if :original_description was changed' do
      @group_event = FactoryGirl.create(:group_event, original_description: 'Test Test Test')
      @group_event.update(original_description: 'Changed text')
      expect(@group_event.formatted_description).to eq("<p>Changed text</p>\n")
    end
  end

end