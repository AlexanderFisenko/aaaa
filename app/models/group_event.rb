class GroupEvent < ActiveRecord::Base
  include AASM

  belongs_to :user

  validates_presence_of :name, :original_description, :starts_at
  validates_presence_of :ends_at_or_duration

  before_save :set_duration,              unless: :duration
  before_save :set_ends_at,               unless: :ends_at
  before_save :set_formatted_description, if: Proc.new { |group_event| group_event.original_description_changed? }

  aasm column: 'state' do
    state :draft, initial: true
    state :published
    state :deleted

    event :publish do
      transitions from: :draft, to: :published, guard: :has_no_blank_fields?
    end

    event :delete do
      transitions from: [:draft, :published], to: :deleted
    end
  end

  def has_no_blank_fields?
    attribute_names.each do |column_name|
      return false if self.send(column_name).blank?
    end
    true
  end

  private

  def ends_at_or_duration
    ends_at.present? || duration.present?
  end

  def set_ends_at
    self.ends_at = starts_at + duration.days
  end

  def set_duration
    self.duration = (ends_at - starts_at).to_i
  end

  def set_formatted_description
    self.formatted_description = markdown(original_description)
  end

  def markdown(text)
    options = [:hard_wrap, :filter_html, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
    return Markdown.new(text, *options).to_html.html_safe
  end


end
