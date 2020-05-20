class AddTitleToWorks < ActiveRecord::Migration[6.0]
  def change
    add_column :works, :title, :string
  end
end
