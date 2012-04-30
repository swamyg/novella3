class RequestsController < ApplicationController
  def new
    @novel = Novel.find_by_perma_link(params[:novel_id])
    @request = Request.new
  end

  def create
    @novel = Novel.find_by_perma_link(params[:novel_id])
    @request = Request.create!(:novel_id => @novel.id,
                               :from_user_id => current_user.id,
                               :to_user_id => @novel.author.id,
                               :message => params[:request][:message])
    if @request
      flash[:success] = "Your request has been sent to the user"
      redirect_to novel_path(@novel.perma_link)
    else
      flash[:error] = "Something went wrong, try again!"
      render :action => :new
    end
  end

  def index
    @pending_requests = current_user.sent_requests.pending
    @approved_requests = current_user.sent_requests.approved
    @denied_requests = current_user.sent_requests.denied
    @received_requests = current_user.received_requests.pending
  end

  def handle
    @request = Request.find(params[:id])
    @comment = params[:comment] || nil
    case params[:commit]
      when "approve"
        approve
      when "deny"
        deny
      when "cancel", "dismiss"
        dismiss
    end
    redirect_to :action => :index
  end

  def approve
    @request.novel.permissions.create!(:user => @request.from_user, :role => 'editor')
    @request.update_attributes! :status => 'approved', :comment => @comment
    flash[:success] = "User successfully authorized to edit the novel"
  end

  def deny
    @request.update_attributes! :status => 'denied', :comment => @comment
    flash[:success] = "User has been denied permission to edit the novel"
  end

  def dismiss
    @request.destroy
    flash[:success] = "Your request has successfully been dismissed"
  end

end