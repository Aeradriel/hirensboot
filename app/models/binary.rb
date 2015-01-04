class Binary < ActiveRecord::Base
  has_many :win_img_binaries
  has_many :windows_images, through: :win_img_binaries
end
