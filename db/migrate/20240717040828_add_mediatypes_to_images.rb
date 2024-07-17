class AddMediatypesToImages < ActiveRecord::Migration[7.1]
  def change
    add_column :images, :mediatype1, :string
    add_column :images, :mediatype2, :string
    add_column :images, :mediatype3, :string
    add_column :images, :mediatype4, :string
    add_column :images, :mediatype5, :string
    add_column :images, :mediatype6, :string
    add_column :images, :mediatype7, :string
    add_column :images, :mediatype8, :string
    add_column :images, :mediatype9, :string
    add_column :images, :mediatype10, :string
  end
end
