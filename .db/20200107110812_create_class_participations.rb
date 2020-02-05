class CreateClassParticipations < ActiveRecord::Migration[5.2]
  def change
    create_table :class_participations do |t|

      t.timestamps
    end
  end
end
