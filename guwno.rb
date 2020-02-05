require 'active_record'
require 'tiny_tds'
require 'activerecord-sqlserver-adapter'
require 'pp'

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
  create_table :curriculums#, force: true do |t|
    t.string :curriculum_name, limit: 40
  end
end

#Create a new table called Courses
ActiveRecord::Schema.define do
  create_table :courses#, force: true do |t|
    t.belongs_to :curriculum
    t.string :course_name, limit: 40
    t.integer :credit_points, limit: 2 # 2 digits long integer
  end
end

#Create a new table called CourseForms
ActiveRecord::Schema.define do
  create_table :course_forms#, force: true do |t|
    t.belongs_to :course
    t.string :class_type, limit: 1 # 1 character long VARCHAR
  end
end

#Create a new table called Classes
ActiveRecord::Schema.define do
  create_table :classes#, force: true do |t|
    t.belongs_to :course_form
    t.belongs_to :teacher

    t.integer :weekday, :limit => 1 # 1 - Monday, 2 - Tuesday, ...
    t.time :begin_time
    t.time :end_time

    t.integer :places_available, :limit => 3
  end
end


#Create a new table called Teachers
ActiveRecord::Schema.define do
  create_table :teachers#, force: true do |t|
    t.belongs_to :curriculum
    t.belongs_to :address
    t.string :first_name, limit: 32
    t.string :middle_name, limit: 32
    t.string :last_name, limit: 32
    t.integer :employee_number, limit: 6
    t.binary :password_hash, limit: 64
    t.email :string, limit: 60
  end
end

#Create a new table called Students
ActiveRecord::Schema.define do
  create_table :students#, force: true do |t|
    t.belongs_to :curriculum
    t.belongs_to :address
    t.string :first_name, limit: 32
    t.string :middle_name, limit: 32
    t.string :last_name, limit: 32
    t.integer :index_number, limit: 6
    t.date :birth_date
    t.integer :beginning_year, limit: 4 # set to 0 when not verified
    t.integer :current_semester, limit: 2
    t.binary :password_hash, limit: 64
    t.email :string, limit: 60
  end
end

#Create a new table called Administrators
ActiveRecord::Schema.define do
  create_table :administrators#, force: true do |t|
    t.belongs_to :address
    t.string :first_name, limit: 32
    t.string :middle_name, limit: 32
    t.string :last_name, limit: 32
    t.integer :employee_number, limit: 6
    t.binary :password_hash, limit: 64
    t.email :string, limit: 60
  end
end


#Create a new table called Bureaucrats
ActiveRecord::Schema.define do
  create_table :abureaucrats#, force: true do |t|
    t.belongs_to :address
    t.string :first_name, limit: 32
    t.string :middle_name, limit: 32
    t.string :last_name, limit: 32
    t.integer :employee_number, limit: 6
    t.binary :password_hash, limit: 64
    t.email :string, limit: 60
  end
end

class Task < ActiveRecord::Base
end

#Create new tasks and users
Task.create!(taskname:'Install SQL Server 2017 on Windows', user:'Andrea', duedate: '2017-07-01')
Task.create!(taskname:'Upgrade from SQL Server 2014 to 2017', user:'Meet', duedate: '2017-07-01')
Task.create!(taskname:'Write new SQL Server content', user:'Luis', duedate: '2017-07-01')
pp "Created new tasks:"
pp Task.all

#Update due date for specific task
task_to_update = Task.where(taskname: 'Install SQL Server 2017 on Windows').where(user: 'Andrea').first
puts "Updating the following task:"
pp task_to_update
task_to_update.update_attribute(:duedate, '2017-07-31')
puts "Due date changed:"
pp task_to_update

#Destroy all tasks for specific user
tasks_to_delete = Task.where(user: 'Meet').first
puts "Deleting all tasks for user:"
pp tasks_to_delete
tasks_to_delete.destroy!

#Read all tasks
puts "Printing all tasks:"
pp Task.all

ActiveRecord::Base.connection.close
