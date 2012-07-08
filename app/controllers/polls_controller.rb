class PollsController < ApplicationController
  def chapter
    chapter = Chapter.find(params[:id])
    render :json => {:editors => chapter.concurrent_editors}
  end
end