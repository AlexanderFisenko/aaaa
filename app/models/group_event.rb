class GroupEvent < ActiveRecord::Base
  include AASM

  belongs_to :user

  validates_presence_of :name, :description

  validates_presence_of :name, :description, :location, :duration, :starts_at, :ends_at,
        if: Proc.new { |record| record.aasm_state == 'published' }

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

end
