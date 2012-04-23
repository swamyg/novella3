class UsersController < ApplicationController
  def show
    @user = User.find_by_login(params[:id])
    if @user.nil?
      flash[:notice] = "Wrong user login, no such person"
      redirect_to '/'
    else
      redirect_to '/users/'+@user.login
    end
  end 
end
