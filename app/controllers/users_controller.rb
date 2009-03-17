class UsersController < ApplicationController
  def index
    @users = User.find(:all, :order => 'created_at DESC', :conditions => ["id != ?", logged_in_user.id])
  end

  def home
    @user = User.find(params[:user_id]) 
    @entries = @user.entries.find(:all, :order => 'created_at DESC') 
    @albums = @user.albums.find(:all, :order => 'created_at DESC')
    @friends = @user.friendships
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      self.logged_in_user= @user
      flash[:notice] = "用户注册成功"
      redirect_to home_path(:user_id => @user.id)
    else render :action => 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if logged_in_user.hashed_password == User.encrypt_password(params[:user][:oldpassword], logged_in_user.salt)
      if User.change_password?(params[:user])
        flash[:notice] = "密码更改完毕"
        render :action => 'edit'
      else
        flash[:error] = "两次密码输入不一致"
        redirect_to :action => 'edit'
      end
    else
      flash[:error] = "当前密码输入错误"
      redirect_to :action => 'edit'
    end
  end
end
