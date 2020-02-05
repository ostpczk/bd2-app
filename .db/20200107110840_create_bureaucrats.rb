class CreateBureaucrats < ActiveRecord::Migration[5.2]
  def change
    create_table :bureaucrats do |t|

      t.timestamps
    end
  end
end
