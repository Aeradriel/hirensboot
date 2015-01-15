class WindowsImage < ActiveRecord::Base
  validates :name, uniqueness: true, presence: true
  validates_presence_of :path

  has_many :win_img_binaries
  has_many :binaries, through: :win_img_binaries
end
