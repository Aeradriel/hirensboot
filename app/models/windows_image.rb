class WindowsImage < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :path

  belongs_to :user
  has_many :win_img_binaries
  has_many :binaries, through: :win_img_binaries
end
