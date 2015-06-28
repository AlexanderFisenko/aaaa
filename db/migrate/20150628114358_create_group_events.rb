class CreateGroupEvents < ActiveRecord::Migration
  def change
    create_table :group_events do |t|
      t.string     :name
      t.string     :aasm_state
      t.string     :location
      t.text       :description
      t.date       :start_at
      t.date       :end_at
      t.integer    :duration
      t.references :user, index: true

      t.timestamps
    end
  end
end
