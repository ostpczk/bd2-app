class PagesController < ApplicationController
  def home
    if signed_in?
      redirect_to users_url
    end
  end 
end
