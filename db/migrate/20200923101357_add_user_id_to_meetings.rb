class AddUserIdToMeetings < ActiveRecord::Migration[6.0]
  def change
    add_reference :meetings, :user, foreign_key: true, null: false
  end
end
