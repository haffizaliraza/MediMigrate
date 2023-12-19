class UsersController < BaseController
  before_action :authorize_request, except: %i[edit_profile update_profile]
  before_action :set_user, only: %i[edit destroy update edit_profile update_profile]

  def index
    @users = User.ordered.page(params[:page])
  end

  def new
    @user = User.new
  end

  def edit; end

  def edit_profile
    return root_path, alert: 'Not Authorized'  unless valid_user
  end

  def update_profile
    return root_path, alert: 'Not Authorized'  unless valid_user
    if @user.update(user_params)
      redirect_to root_path, notice: "Profile updated successfully"
    else
      render :edit_profile, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      respond_to do |format|
        format.html { redirect_to users_path, notice: "#{@user.type} #{@user.name} updated successfully"}
        format.json { render json: { user: @user } }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: "#{@user.type} #{@user.name} created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @result = @user.destroy
    if @result
      redirect_to users_path, notice: "#{@user.type} #{@user.name} deleted successfully"
    else
      flash.now[:alert] = @user.errors.full_messages.to_sentence
    end
  end

  private

  def valid_user
    current_user.id ==  @user.id
  end

  def authorize_request
    authorize %i[user]
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    user = params[:user] || params[:admin_user] || params[:employer] || params[:student]
    user.permit(:name, :email, :password, :password_confirmation, :type, :status)
  end
end
