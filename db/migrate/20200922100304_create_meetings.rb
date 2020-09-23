class CreateMeetings < ActiveRecord::Migration[6.0]
  def change
    create_table :meetings do |t|
      t.string :label, null: false
      t.string :detail, null: false
      t.datetime :start_time, null: false

      t.timestamps
    end
  end
end
