class CreateReptiles < ActiveRecord::Migration[6.0]
  def change
    create_table :reptiles do |t|
      t.string :image
      t.string :type1
      t.string :type2
      t.string :type_name
      t.string :morph
      t.string :sex
      t.string :age
      t.string :size
      t.string :weight
      t.string :description
      t.integer :price
      t.string :sales_status
      t.date :arrival_day
      t.integer :user_id
      
      t.timestamps
    end
  end
end
