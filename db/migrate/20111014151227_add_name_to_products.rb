class AddNameToProducts < ActiveRecord::Migration
  def change
    add_column :products, :name, :string
    add_column :products, :description, :string
    add_column :products, :image, :text
  end
end
