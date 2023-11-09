class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :user_id, null: false
      t.integer :product_id, null: false
      t.text :body, null: false
      t.float :rate, null: false

      t.timestamps
    end
  end
end
