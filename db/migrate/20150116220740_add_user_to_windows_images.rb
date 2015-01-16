class AddUserToWindowsImages < ActiveRecord::Migration
  def change
    add_reference :windows_images, :user, index: true
  end
end
