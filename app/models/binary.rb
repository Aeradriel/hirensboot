class Binary < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :path

  has_many :win_img_binaries
  has_many :windows_images, through: :win_img_binaries
end
