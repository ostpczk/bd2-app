class Administrator < ActiveRecord::Base
  has_secure_password
  belongs_to :address
end
