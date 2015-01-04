class CreateWinImgBinaries < ActiveRecord::Migration
  def change
    create_table :win_img_binaries do |t|
      t.belongs_to :windows_image
      t.belongs_to :binary

      t.timestamps
    end
  end
end
