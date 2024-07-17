class AddAccountNameToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :account_name, :string
  end
end
