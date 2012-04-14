class ProfilesController < ApplicationController
  def show
    params[:user_id] = params[:login]? params[:login] :  params[:user_id]
    @user = User.find_by_id_or_login(params[:user_id]).first
    if !@user.nil?
      @profile = @user.profile      
    else
      flash[:notice] = "No such person exists, yet"
      redirect_to '/'
    end
  end
  
  def edit    
    @user = User.find_by_id_or_login(params[:user_id]).first
    if @user.id == current_user.id
      @profile = @user.profile
    else
      redirect_to '/'
      flash[:notice] = "You cannot edit other people's profile"
    end  
  end
  
  def update
    @user = User.find(params[:user_id])
    @profile = @user.profile    
    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        flash[:notice] = 'profile was successfully updated.'
        format.html { redirect_to(profile_path(@user.login)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
      end
    end
  end

end
