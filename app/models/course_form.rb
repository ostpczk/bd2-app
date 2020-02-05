
class CourseForm < ActiveRecord::Base
  belongs_to :course
  has_many :class_activities
end
