class ChaptersController < ApplicationController
  # GET /chapters
  # GET /chapters.xml
  before_filter :login_required, :except=>[:show,:index]
  before_filter :set_novel, :except => [:index]
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
    @chapter = Chapter.find(params[:id])
    @chapter_count = @novel.chapters.count
    @chapter.concurrent_editors +=1
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
    redirect_to chapter_no_path(@novel.perma_link,@chapter.number)
    flash[:success] = "Chapter was created successfully, You can continue adding chapters."
    #@novel.unlock
    rescue ActiveRecord::RecordInvalid
      render :action => 'new'
  end    
  

  # PUT /chapters/1
  # PUT /chapters/1.xml
  def update
    @chapter = Chapter.find(params[:id])

    respond_to do |format|
      if @chapter.update_attributes(params[:chapter])
        flash[:notice] = 'Chapter was successfully updated.'
        #@novel.unlock
        format.html { redirect_to(novel_chapter_path(@novel.perma_link, @chapter.number)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @chapter.errors, :status => :unprocessable_entity }
      end
    end
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

  def reset
    @chapter.reset
  end

  def set_novel
    @novel = Novel.find_by_perma_link(params[:novel_id])
    @chapter = @novel.chapters.build
  end
end
