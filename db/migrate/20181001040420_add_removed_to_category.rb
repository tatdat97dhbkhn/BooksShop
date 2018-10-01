class AddRemovedToCategory < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :removed, :integer, default: 0
  end
end
