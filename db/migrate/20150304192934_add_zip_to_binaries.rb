class AddZipToBinaries < ActiveRecord::Migration
  def change
    add_column :binaries, :zip, :boolean, default: false
  end
end
