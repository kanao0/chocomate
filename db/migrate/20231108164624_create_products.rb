class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.integer :brand_id, null: false
      t.integer :type_id, null: false
      t.integer :origin_id, null: false
      t.string :name, null: false
      t.integer :price, null: false

      t.timestamps
    end
  end
end
