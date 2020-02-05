class Teacher < ActiveRecord::Base
  has_secure_password
  belongs_to :curriculum
  belongs_to :address
end
