class UsersController < ApplicationController

  before_action :check_status, except: [:index, :register, :log]

  def index
    if session[:user_id]
      redirect_to ("/show/#{session[:user_id]}")
    end
  end

  def show

    @ideas = Idea.all
    @user = User.find(session[:user_id])

    ### FOR SORTING LIKES ###
    arr = []
    @ideas.each do |idea|
      dic = {}
      dic[:id] = idea.id
      dic[:count] = idea.liked_users.count
      arr.push(dic)
    end
    arr.sort_by! { |dic| dic[:count]}

    order = []
    i = arr.count - 1
    while i >= 0
      order.push(arr[i][:id])
      i -= 1
    end
    ##ACTUAL LIST THAT YOU WANT TO PRINT ###
    @list = []
    order.each do |x|
      @list.push(Idea.find(x))
    end
    ### END OF REALLY MESSY LOGIC ###
  end

  def view
    @user = User.find(params[:id])
  end

  def register
    user = User.create(name: params[:name], alias: params[:alias], email: params[:email], password: params[:pw], password_confirmation: params[:pw_confirm])
    if user.valid?
      session[:user_id] = user.id
      redirect_to ("/show/#{user.id}")
    else
      flash[:errors] = user.errors.full_messages.to_sentence
      redirect_to ('/')
    end
  end

  def log
    user = User.find_by_email(params[:email])

    if user && user.authenticate(params[:pw])
      puts user.id
      session[:user_id] = user.id
      redirect_to ("/show/#{user.id}")
    else
      flash[:log_error] = "Something was wrong with log in credentials, please try again"
      redirect_to ('/')
    end
  end

  def out
    reset_session
    redirect_to ('/')
  end

  def idea
    user = User.find(session[:user_id])
    idea = Idea.create(content: params[:idea], user:user)
    if idea.valid?
      redirect_to ("/show/#{user.id}")
    else
      flash[:errors] = idea.errors.full_messages.to_sentence
      redirect_to ("/show/#{user.id}")
    end
  end

  def destroy_idea
    user = User.find(session[:user_id])
    Idea.find(params[:id]).destroy
    redirect_to ("/show/#{user.id}")
  end

  def like
    idea = Idea.find(params[:id])
    user = User.find(session[:user_id])
    Like.create(idea: idea, user:user)
    redirect_to ("/show/#{user.id}")
  end

  def unlike
    idea = Idea.find(params[:id])
    user = User.find(session[:user_id])
    Like.where(user:user, idea:idea).destroy_all
    redirect_to ("/show/#{user.id}")
  end

  def check_status
    if !session[:user_id]
      redirect_to ('/')
    end
  end
end
