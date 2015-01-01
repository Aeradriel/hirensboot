class AddNameToWindowsImage < ActiveRecord::Migration
  def change
    add_column :windows_images, :name, :string
  end
end
