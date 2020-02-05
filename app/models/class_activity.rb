class ClassActivity < ActiveRecord::Base
  belongs_to :course_form
  belongs_to :teacher
  has_many :class_participations
end
