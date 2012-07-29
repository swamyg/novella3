class CharactersController < ApplicationController
  # GET /chapters
  # GET /chapters.xml
  before_filter :login_required, :except=>[:show,:index]
  before_filter :set_novel
  before_filter :set_character, :except => [:index]
  load_and_authorize_resource
  def index
    @characters = @novel.characters
  end

  # GET /chapters/1
  # GET /chapters/1.xml
  def show
    @character = @novel.characters.where("id=#{params[:id]}").first
    @chapter_count = @novel.chapters.count
  end

  # GET /chapters/new
  # GET /chapters/new.xml
  def new
    #@chapter = Chapter.new
    #@novel = Novel.find(params[:novel_id])
    #@chapter_count = @novel.chapters.count
  end

  # GET /chapters/1/edit
  def edit
    @chapter = Chapter.find(params[:id])
    @chapter_count = @novel.chapters.count
  end

  # POST /chapters
  # POST /chapters.xml
  def create
    @character = Character.new(params[:character])
    return unless request.post?
    #@novel = Novel.find_by_perma_link(params[:novel_id])
    #@chapter_count = @novel.chapters.count
    #@chapter.number = @chapter_count + 1
    #@chapter.content.gsub!(/\n/, '<br/>') #convert new lines into paragraphs
    @character.user_id = current_user.id
    @character.novel_id = @novel.id
    @character.save!
    redirect_to novel_characters_path(@novel.perma_link)
    flash[:success] = "Character was created successfully."
  rescue ActiveRecord::RecordInvalid
    flash[:success] = "There was a problem creating your character, please try again."
      render :action => 'new'
  end


  # PUT /chapters/1
  # PUT /chapters/1.xml
  def update
    @chapter = Chapter.find(params[:id])

    respond_to do |format|
      if @chapter.update_attributes(params[:chapter])
        flash[:notice] = 'Chapter was successfully updated.'
        format.html { redirect_to(@chapter) }
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
  end

  def set_character
    @character = params[:id] ? @novel.characters.find_by_id(params[:id]) : @novel.characters.build
  end
end
