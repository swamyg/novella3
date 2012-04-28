class PermissionsController < ApplicationController
  def new
    @novel = Novel.find_by_perma_link(params[:novel_id])
    @request = Request.new
  end

  def create
    @novel = Novel.find_by_perma_link(params[:novel_id])
    @request = Request.create!(:novel_id => @novel.id, :from_user_id => current_user.id, :to_user_id => @novel.author.id, :message => params[:request][:message])
    if @request
      flash[:success] = "Your request has been sent to the user"
      redirect_to novel_path(@novel.perma_link)
    else
      flash[:error] = "Something went wrong, try again!"
      render :action => :new
    end
  end
end