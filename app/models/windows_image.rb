class WindowsImage < ActiveRecord::Base
  has_many :win_img_binaries
  has_many :binaries, through: :win_img_binaries
end
