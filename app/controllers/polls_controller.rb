class PollsController < ApplicationController
  def chapter
    puts "Current_user ---> #{current_user.id}"
    render :json => {:success => 'true', :visitors => 100}
  end
end