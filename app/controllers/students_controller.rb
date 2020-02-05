class StudentsController < ApplicationController
  def new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to @student
    else
      render 'new'
    end
  end

  def destroy
  end

  private
    def student_params
      params.require(:student).permit(:first_name, :middle_name, :last_name, :index_number, :birth_date, :password, :email, address: [:street_name, :house_number, :flat_number, :city, :postal_code, :country])
    end

end
