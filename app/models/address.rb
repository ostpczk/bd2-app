class Address < ActiveRecord::Base
  has_many :students
  has_many :teachers
  has_many :administrators
  has_many :bureaucrats
end
