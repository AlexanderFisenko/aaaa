class CreateGroupEvents < ActiveRecord::Migration
  def change
    create_table :group_events do |t|
      t.string     :name
      t.string     :state
      t.string     :location
      t.text       :original_description
      t.text       :formatted_description
      t.date       :starts_at
      t.date       :ends_at
      t.integer    :duration
      t.references :user, index: true

      t.timestamps
    end
  end
end
