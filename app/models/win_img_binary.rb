class WinImgBinary < ActiveRecord::Base
  belongs_to :binary
  belongs_to :windows_image
end
