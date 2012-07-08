class AccountsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  # If you want "remember me" functionality, add this before_filter to Application Controller
  before_filter :login_from_cookie

  # say something nice, you goof!  something sweet.
  def index
    redirect_to(:action => 'signup') unless logged_in? || User.count > 0
  end

  def login
    if logged_in?
      redirect_back_or_default('/')
      flash[:notice] = "You are already logged in, please signout to login"    
    end
    return unless request.post?
    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in?
      if params[:remember_me] == "1"
        self.current_user.remember_me
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      session[:user] = self.current_user
      redirect_back_or_default('/')
      flash[:notice] = "Logged in successfully"
     else
       redirect_back_or_default(:controller => '/accounts', :action => 'login')
       flash[:notice] = "Please ensure your login and/or password is correct"          
    end
  end

  def signup
    @user = User.new(params[:user])
    return unless request.post?
    @user.save!
    @profile = Profile.new
    @profile.user_id = @user.id
    @profile.save!
    self.current_user = @user
    session[:user] = self.current_user
    puts " YAYAYAY * ****************yo********************************************* "
    redirect_back_or_default(:controller => '/accounts', :action => 'login')
    flash[:success] = "Account created successfully, please login"
  rescue ActiveRecord::RecordInvalid
    render :action => 'signup'
  end
  
  def logout
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end
end
