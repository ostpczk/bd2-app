class CreateClassActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :class_activities do |t|

      t.timestamps
    end
  end
end
