class GenreController < ApplicationController
  def show
    @view = params[:view]=='recent' ? 'recent' : 'popular'
    if params[:genre]=='all' || !params[:genre]
      @genre = Genre.new
      @genre.id = 0
      @genre.name = "all"
    else
      @genre = Genre.find_by_name(params[:genre])
    end
      @novels = @view == 'popular' ? Novel.popular(@genre.id,params[:page]) : Novel.recent(@genre.id,params[:page])
      if false
      @novels.each do |novel|      
      puts " ************************************** "+@novels.id.to_s
      puts " **************************NOVEL user IS:"+@novels.user.id.to_s
      end
      end
  end
end
