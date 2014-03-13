class UsersController < ApplicationController
  before_action :signed_in_user,
                only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.leave = 0
    @user.workhour = 0
    @user.visible = 0
    @user.overtime_count = 0
    @user.ideal_workhour = 0
    @user.leave_count = 0
    @user.paid_leave_count = 0
    @user.overtime_allocation = 0

    cntr = 0

    for i in ["1","2","3"] do
	cntr = cntr + 1
	if @user.designation == i
	@user.designation_id = cntr
	end
    end
	
    
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to WorkDay Scheduler"
      redirect_to(root_url)
	
	User.find_in_batches do |group|
        group.each do |user|
          if(current_user.designation_id <= user.designation_id && current_user!=user)
            current_user.follow!(user)
          end
          if(current_user.designation_id >= user.designation_id && current_user!=user)
            user.follow!(current_user)
          end
       end
    end
    else
      render 'new'
    end
  end

  def edit
  end

  def update

	User.find_in_batches do |group|
        group.each do |user|
          if(current_user!=user)
            current_user.unfollow!(user)
            user.unfollow!(current_user)
          end
       end
	end

	cntr = 0

    if @user.update_attributes(user_params) 
      flash[:success] = "Profile updated"
	
	for i in ["1","2","3"] do
	cntr = cntr + 1
	if @user.designation == i
	@user.designation_id = cntr
	end
	end
	@user.save
	
	User.find_in_batches do |group|
        group.each do |user|
          if(current_user.designation_id <= user.designation_id && current_user!=user)
            current_user.follow!(user)
          end
          if(current_user.designation_id >= user.designation_id && current_user!=user)
            user.follow!(current_user)
          end
         end
        end

	 redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :designation, :password,
                                   :password_confirmation, :designation_id)
    end

    # Before filters

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
  end
