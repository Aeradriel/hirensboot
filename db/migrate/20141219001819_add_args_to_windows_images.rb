class AddArgsToWindowsImages < ActiveRecord::Migration
  def change
    add_column :windows_images, :path, :string
    add_column :windows_images, :expiration_date, :datetime
  end
end
