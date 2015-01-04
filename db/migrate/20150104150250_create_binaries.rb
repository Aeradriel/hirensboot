class CreateBinaries < ActiveRecord::Migration
  def change
    create_table :binaries do |t|
      t.string :path
      t.string :name
      t.timestamps
    end
  end
end
