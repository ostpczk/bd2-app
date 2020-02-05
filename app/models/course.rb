class Course < ActiveRecord::Base
  belongs_to :curriculum
  has_many :course_forms
end
