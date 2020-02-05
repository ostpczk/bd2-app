module SessionsHelper

  def current_user=(user)
    @current_user = user
  end

  def current_user
    if @current_user.is_a? Student
      remember_token = Student.digest(cookies[:remember_token])
      @current_user ||= Student.find_by(remember_token: remember_token)
    elsif @current_user.is_a? Teacher
      remember_token = Teacher.digest(cookies[:remember_token])
      @current_user ||= Teacher.find_by(remember_token: remember_token)
    elsif @current_user.is_a? Bureaucrat
      remember_token = Bureaucrat.digest(cookies[:remember_token])
      @current_user ||= Bureaucrat.find_by(remember_token: remember_token)
    elsif @current_user.is_a? Administrator
      remember_token = Administrator.digest(cookies[:remember_token])
      @current_user ||= Administrator.find_by(remember_token: remember_token)
    end
  end

  def sign_in(user)

    if @current_user.is_a? Student
    remember_token = Student.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, Student.digest(remember_token))
    self.current_user = user

    elsif @current_user.is_a? Teacher
    remember_token = Teacher.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, Teacher.digest(remember_token))
    self.current_user = user

    elsif @current_user.is_a? Bureaucrat
    remember_token = Bureaucrat.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, Bureaucrat.digest(remember_token))
    self.current_user = user

    elsif @current_user.is_a? Administrator
    remember_token = Administrator.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, Administrator.digest(remember_token))
    self.current_user = user
    end
  end

  def signed_in?
    !current_user.nil?
  end
end

  def sign_out

    if @current_user.is_a? Student
    current_user.update_attribute(:remember_token,
                                  Student.digest(Student.new_remember_token))
    elsif @current_user.is_a? Teacher
    current_user.update_attribute(:remember_token,
                                  Teacher.digest(Teacher.new_remember_token))

    elsif @current_user.is_a? Bureaucrat
    current_user.update_attribute(:remember_token,
                                  Bureaucrat.digest(Bureaucrat.new_remember_token))

    elsif @current_user.is_a? Administrator
    current_user.update_attribute(:remember_token,
                                  Administrator.digest(Administrator.new_remember_token))
    end

    cookies.delete(:remember_token)
    self.current_user = nil
  end

