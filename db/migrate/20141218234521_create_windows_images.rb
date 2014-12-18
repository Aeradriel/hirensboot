class CreateWindowsImages < ActiveRecord::Migration
  def change
    create_table :windows_images do |t|

      t.timestamps
    end
  end
end
