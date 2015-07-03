class GroupEvent < ActiveRecord::Base
  include AASM

  belongs_to :user

  validates_presence_of :name, :original_description

  validates_presence_of :name, :original_description, :location, :duration, :starts_at, :ends_at,
        if: Proc.new { |record| record.aasm_state == 'published' }

  before_save :set_ends_at,               if: Proc.new { |group_event| group_event.ends_at.blank? }
  before_save :set_duration,              if: Proc.new { |group_event| group_event.duration.blank? }
  before_save :set_formatted_description, if: Proc.new { |group_event| group_event.formatted_description.blank? }

  aasm do
    state :draft, initial: true
    state :published
    state :deleted

    event :publish do
      transitions from: :draft, to: :published
    end

    event :delete do
      transitions from: [:draft, :published], to: :deleted
    end
  end



  private

  def set_ends_at
    self.ends_at = starts_at + duration.days
  end

  def set_duration
    self.duration = (ends_at - starts_at).to_i
  end

  def set_formatted_description
    self.formatted_description = ApplicationController.helpers.markdown(original_description)
  end
end
