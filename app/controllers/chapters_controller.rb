class ChaptersController < ApplicationController
  # GET /chapters
  # GET /chapters.xml
  before_filter :login_required, :except=>[:show,:index]
  before_filter :set_novel, :except => [:index, :unload]
  load_and_authorize_resource
  def index
    @user = User.find_by_login(params[:user_id])
    if !@user.nil?
      @profile = @user.profile
      @user_chapters_novels = Array.new
      @user.chapters.find(:all,:group=>'novel_id').each do |user_chapter|
        @user_chapters_novels << user_chapter.novel #add the novel who's chapter the user has contributed to.      
      end
      #@user_chapters_novels = @user_chapters_novels.uniq  #remove redundancies
      flash[:notice] = "This person has not contributed chapters to any novels, yet" if @user.chapters.count==0      
    else
      flash[:notice] = "No such person exists, yet"
      redirect_to '/'
    end
  end

  # GET /chapters/1
  # GET /chapters/1.xml
  def show
    @chapter = @novel.chapters.where("number=#{params[:id]}").first
    @chapter_count = @novel.chapters.count
  end
  
  # GET /chapters/new
  # GET /chapters/new.xml
  def new
    #@chapter = Chapter.new
    #@novel = Novel.find(params[:novel_id])
    #if @novel.locked?(current_user)
    #  flash[:notice] = "This novel is currently locked for editing. If you are the author please release lock and try again."
    #  return redirect_to perma_link_path(@novel.perma_link)
    #end
    @chapter_count = @novel.chapters.count
    #@novel.lock(current_user)
  end

  # GET /chapters/1/edit
  def edit
    #if @novel.locked?(current_user)
    #  flash[:notice] = "This novel is currently locked for editing. If you are the author please release lock and try again."
    #  return redirect_to perma_link_path(@novel.perma_link)
    #end
    #@chapter = Chapter.find(params[:id])
    @chapter = @novel.chapters.where("number=#{params[:id]}").first
    @chapter_count = @novel.chapters.count
    @chapter.skip_version do
      @chapter.update_attribute :current_edit_id, rand(9999999) if @chapter.concurrent_editors == 0
    end
    @chapter.add_concurrent_editor(current_user)
    #@novel.lock(current_user)
  end
  
  # POST /chapters
  # POST /chapters.xml
  def create
    @chapter = Chapter.new(params[:chapter])
    return unless request.post?
    #@novel = Novel.find_by_perma_link(params[:novel_id])
    @chapter_count = @novel.chapters.count
    @chapter.number = @chapter_count + 1
    @chapter.content.gsub!(/\n/, '<br/>') #convert new lines into paragraphs
    @chapter.user_id = current_user.id
    @chapter.novel_id = @novel.id
    @chapter.save!
    flash[:success] = "Chapter was created successfully, You can continue adding chapters."
    redirect_to chapter_no_path(@novel.perma_link,@chapter.number)
    #@novel.unlock
    rescue ActiveRecord::RecordInvalid
      render :action => 'new'
  end    
  

  # PUT /chapters/1
  # PUT /chapters/1.xml
  def update
    @chapter = @novel.chapters.where("number=#{params[:id]}").first

    respond_to do |format|
      params[:chapter][:updated_by] = current_user
      if @chapter.update_attributes(params[:chapter])
        flash[:notice] = 'Chapter was successfully updated.'
        @chapter.remove_concurrent_editor(current_user)
        @chapter.skip_version do
          @chapter.update_attribute :current_edit_id, nil if @chapter.concurrent_editors == 0
        end
        format.html { redirect_to(novel_chapter_path(@novel.perma_link, @chapter.number)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @chapter.errors, :status => :unprocessable_entity }
      end
    end
  end

  def unload
    #@chapter = @novel.chapters.where("number=#{params[:id]}").first
    @chapter.remove_concurrent_editor(current_user)
    @chapter.skip_version do
      @chapter.update_attribute :current_edit_id, nil if @chapter.concurrent_editors == 0
    end
    render :nothing => true
  end

  # DELETE /chapters/1
  # DELETE /chapters/1.xml
  def destroy
    @chapter = Chapter.find(params[:id])
    @chapter.destroy

    respond_to do |format|
      format.html { redirect_to(chapters_url) }
      format.xml  { head :ok }
    end
  end

  def changes
    @chapter = @novel.chapters.where("number=#{params[:id]}").first
    @chapter_count = @novel.chapters.count
    if params[:revert_to]
      @chapter.revert_to!(params[:revert_to].to_i)
      flash[:success] = "Chapter successfully reverted to version #{params[:revert_to]}"
      redirect_to chapter_no_path(@novel.perma_link,@chapter.number)
    end
  end

  def reset
    @chapter.reset
  end

  def set_novel
    @novel = Novel.find_by_perma_link(params[:novel_id])
    @chapter = @novel.chapters.build
  end
end
