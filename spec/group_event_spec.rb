require 'rails_helper'

RSpec.describe GroupEvent, :type => :model do
  describe '#has_no_blank_fields?' do
    it 'returns true if instance has no blank fields' do
      group_event = GroupEvent.create(
                      name:      'Test',
                      location:  'test location',
                      user_id:   1,
                      starts_at: Date.today,
                      ends_at:   Date.today + 10.days,
                      original_description: 'Test original description',
                    )

      expect(group_event.has_no_blank_fields?).to be_truthy
    end

    it 'returns false if instance has at least one blank field' do
      group_event = GroupEvent.create(
                      name:      'Test',
                      location:  'test location',
                      user_id:   nil,
                      starts_at: Date.today,
                      ends_at:   Date.today + 10.days,
                      original_description: 'Test original description',
                    )

      expect(group_event.has_no_blank_fields?).to be_falsey
    end
  end

  describe '#set_ends_at' do
    it 'sets :ends_at if :duration and :starts_at is given' do
      group_event = GroupEvent.create(
                      name:      'Test',
                      location:  'test location',
                      starts_at: '2015-01-05',
                      duration:  2,
                      original_description: 'Test original description',
                    )

      expect(group_event.set_ends_at).to eq('2015-01-07')
    end
  end
end