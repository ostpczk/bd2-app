class ClassParticipation < ActiveRecord::Base
  belongs_to :class_activity
  belongs_to :student
end

