class GroupEvent < ActiveRecord::Base
  include AASM

  belongs_to :user

  validates_presence_of :name, :description

  aasm do
    state :draft, initial: true
    state :published
    state :deleted

    event :publish do
      transitions from: :draft, to: :published, guards: [:has_all_attrs?]
    end

    event :delete do
      transitions from: [:draft, :published], to: :deleted
    end
  end

  def has_all_attrs?
    name.present? && description.present? && start_at.present? && end_at.present? && duration.present? && location.present?
  end

end
