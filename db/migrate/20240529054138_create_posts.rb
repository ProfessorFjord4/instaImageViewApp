class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :permalink
      t.integer :has_children
      t.datetime :post_datetime
      t.timestamps
    end
  end
end
