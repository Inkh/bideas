class IdeasController < ApplicationController
  def view
    @idea = Idea.find(params[:id])
    @liked_users = @idea.liked_users
  end
end
