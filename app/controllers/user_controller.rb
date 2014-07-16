class UserController < ApplicationController
 layout 'user'
 before_action :confirm_user_logged_in, :except => [:login, :attempt_login, :register, :create]
  
  def login
  end

  def register
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'user created.'
      redirect_to(:action => 'index')
    else
      render("register")
    end
  end

  def delete
      @user = User.find(params[:id])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:notice] = "user destroyed."
    redirect_to(:action => 'index')
  end

  def index

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:notice] = 'user updated.'
      session[:name] = @user.username
      redirect_to(:controller =>'public', :action => 'index')
    else
      render("edit")
    end
  end


  def attempt_login
    if params[:username].present? && params[:password].present?
      found_user = User.where(:username => params[:username]).first
      if found_user
        authorized_user = found_user.authenticate(params[:password])
      end
    end
    if authorized_user
      # mark user as logged in
      session[:login_id] = authorized_user.id
      session[:name] = authorized_user.username
      flash[:notice] = "You are now logged in."
      redirect_to(:controller => 'public', :action => 'index')
    else
      flash[:notice] = "Invalid username/password combination."
      redirect_to(:action => 'login')
    end
  end

  def logout
    # mark user as logged out
    session[:login_id] = nil
    session[:name] = nil
    flash[:notice] = "Logged out"
    redirect_to(:controller => 'public', :action => 'index')
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name,
      :email, :username, :password)
  end

end
