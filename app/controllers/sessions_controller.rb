class SessionsController < ApplicationController

  def new

  end

  def create
    user = Student.find_by(index_number: params[:session][:login])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to root_url
      return
    end
    user = Teacher.find_by(employee_number: params[:session][:login])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to root_url
      return
    end
    user = Bureaucrat.find_by(employee_number: params[:session][:login])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to_root_url
      return
    end
    user = Administrator.find_by(employee_number: params[:session][:login])
    if user && user.authenticate(params[:session][:password])
      sign_in(user)
      redirect_to root_url
      return
    end
      flash[:error] = 'Invalid email/password combination' # Not quite right!
      redirect_to root_url
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
