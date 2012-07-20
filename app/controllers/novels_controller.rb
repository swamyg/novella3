class NovelsController < ApplicationController
  # GET /novels
  # GET /novels.xml
  before_filter :login_required, :except=>[:show,:index]
  load_resource :find_by => :perma_link
  authorize_resource
  def index    
    @user = User.find_by_login(params[:user_id])
    if !@user.nil?
      @profile = @user.profile
      @novels = @user.novels
      flash[:notice] = "This person has not written any novels, yet" if @novels.count==0
    else
      flash[:notice] = "No such person exists, yet"
      redirect_to '/'
    end                
  end

  # GET /novels/1
  # GET /novels/1.xml
  def show
    #@novel = Novel.find_by_perma_link(params[:id])
    @chapter_count = @novel.chapters.count
    #if params[:lock] == 'release' && current_user.is_author?(@novel)
    #  flash[:success] = "This novel has been unlocked for editing"
    #  @novel.unlock
    #end
    if params[:view_characters]
      @show_characters = true
      @characters = @novel.characters
    else
      @chapters = @novel.chapters
      flash[:notice] = "This novel doesn't seem to have any content, please add a chapter or two" if @chapter_count==0
    end
  end

  # GET /novels/new
  # GET /novels/new.xml
  def new
  end

  # GET /novels/1/edit
  def edit
    #@novel = Novel.find(params[:id])
    #if @novel.locked?(current_user)
    #  flash[:notice] = "This novel is currently locked for editing. If you are the author please release lock and try again."
    #  return redirect_to :action => :show
    #end
    puts "Why are you here?"
    #@novel.lock(current_user)
    @genres = Genre.all
  end

  # POST /novels
  # POST /novels.xml
  def create
    #@novel = Novel.new(params[:novel])
    #return unless request.post?
    @novel.user_id = current_user.id
    @novel.perma_link = to_perma_link(@novel.name)
    @novel.save!
    redirect_to(:controller => '/novels', :action => 'show', :perma_link=>@novel.perma_link)
    flash[:success] = "A Novel was created successfully, You may begin by adding chapters."
    rescue ActiveRecord::RecordInvalid
      render :action => 'new'
  end

  # PUT /novels/1
  # PUT /novels/1.xml
  def update
    #@novel = Novel.find(params[:id])
       
    if @novel.update_attributes(params[:novel])
      flash[:success] = 'Novel was successfully updated.'
      #@novel.unlock
      redirect_to perma_link_path(@novel.perma_link)
    else
      flash[:error] = 'There was a problem, novel was not successfully updated.'
      redirect_to edit_novel_path(@novel.perma_link)
      #redirect_to edit_novels_path(@novel)
    end
  end

  # DELETE /novels/1
  # DELETE /novels/1.xml
  def destroy
    #@novel = Novel.find(params[:id])
    @novel.destroy

    respond_to do |format|
      format.html { redirect_to(novels_url) }
      format.xml  { head :ok }
    end
  end
end
