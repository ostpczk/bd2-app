class CreateCourseForms < ActiveRecord::Migration[5.2]
  def change
    create_table :course_forms do |t|

      t.timestamps
    end
  end
end
