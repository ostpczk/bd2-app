require 'active_record'
require 'tiny_tds'
require 'activerecord-sqlserver-adapter'

ActiveRecord::Base.establish_connection(
  :adapter=> "sqlserver",
  :host => "localhost",
  :username => "sa",
  :password => "Haslo123"
)

#Create new database DziennikDB
puts "Drop and create new database 'DziennikDB'"
ActiveRecord::Base.connection.drop_database('DziennikDB') rescue nil
ActiveRecord::Base.connection.create_database('DziennikDB')
ActiveRecord::Base.connection.use_database('DziennikDB')

#Create a new table called Curriculums
ActiveRecord::Schema.define do
  create_table :curriculums, force: true do |t|
    t.string :curriculum_name, limit: 40
  end
end

#Create a new table called Courses
ActiveRecord::Schema.define do
  create_table :courses, force: true do |t|
    t.belongs_to :curriculum
    t.string :course_name, limit: 40
    t.integer :credit_points, limit: 2 # 2 digits long integer
  end
end

#Create a new table called CourseForms
ActiveRecord::Schema.define do
  create_table :course_forms, force: true do |t|
    t.belongs_to :course
    t.string :class_type, limit: 1 # 1 character long VARCHAR
  end
end

#Create a new table called ClassActivities
ActiveRecord::Schema.define do
  create_table :class_activities, force: true do |t|
    t.belongs_to :course_form
    t.belongs_to :teacher

    t.integer :weekday, limit: 1 # 1 - Monday, 2 - Tuesday, ...
    t.time :begin_time
    t.time :end_time
    t.integer :places_available, limit: 3, null: true
  end
end

#Create a new table called ClassParticipations
ActiveRecord::Schema.define do
  create_table :class_participations, force: true do |t|
    t.belongs_to :class_activity
    t.belongs_to :student

    t.integer :grade, null: true, limit: 1 # 1 - Monday, 2 - Tuesday, ...
  end
end

#Create a new table called Students
ActiveRecord::Schema.define do
  create_table :students, force: true do |t|
    t.belongs_to :curriculum
    t.belongs_to :address
    t.string :first_name, limit: 32
    t.string :middle_name, limit: 32, null: true
    t.string :last_name, limit: 32
    t.integer :index_number, limit: 6
    t.date :birth_date
    t.integer :beginning_year, limit: 4 # set to 0 when not verified
    t.integer :current_semester, limit: 2
    t.string :password_digest
    t.string :email, limit: 60

    t.string :remember_token

  end
end

#Create a new table called Teachers
ActiveRecord::Schema.define do
  create_table :teachers, force: true do |t|
    t.belongs_to :curriculum
    t.belongs_to :address
    t.string :first_name, limit: 32
    t.string :middle_name, limit: 32, null: true
    t.string :last_name, limit: 32
    t.integer :employee_number, limit: 6
    t.string :password_digest
    t.string :email, limit: 60

    t.string :remember_token
  end
end

#Create a new table called Administrators
ActiveRecord::Schema.define do
  create_table :administrators, force: true do |t|
    t.belongs_to :address
    t.string :first_name, limit: 32
    t.string :middle_name, limit: 32, null: true;
    t.string :last_name, limit: 32
    t.integer :employee_number, limit: 6
    t.string :password_digest
    t.string :email, limit: 60

    t.string :remember_token
  end
end

#Create a new table called Bureaucrats
ActiveRecord::Schema.define do
  create_table :bureaucrats, force: true do |t|
    t.belongs_to :address
    t.string :first_name, limit: 32
    t.string :middle_name, limit: 32, null: true
    t.string :last_name, limit: 32
    t.integer :employee_number, limit: 6
    t.string :password_digest
    t.string :email, limit: 60

    t.string :remember_token
  end
end

#Create a new table called Addresses
ActiveRecord::Schema.define do
  create_table :addresses, force: true do |t|
    t.string :street_name, limit: 45
    t.string :house_number, limit: 5
    t.string :flat_number, limit: 5, null: true
    t.string :city, limit: 32
    t.string :postal_code, limit: 10
    t.string :country, limit: 6
  end
end

ActiveRecord::Base.connection.close
