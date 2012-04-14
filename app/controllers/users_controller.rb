class UsersController < ApplicationController
  def show
    @user = User.find_by_id(params[:id])
    if @user.nil?
      flash[:notice] = "Wrong user ID, no such person"        
      redirect_to '/'
    else
      redirect_to '/users/'+@user.login
    end
  end 
end
