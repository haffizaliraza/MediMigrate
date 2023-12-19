# frozen_string_literal: true

module Users
  #
  # Sessions
  #
  class SessionsController < Devise::SessionsController
    before_action :check_user_login, only: [:create]
    before_action :set_user, only: %i[create]

    # POST /resource/sign_in
    def create
      super
    end
    private

    # if inactive user try to login in this prevent him
    def check_user_login
      return unless current_user&.in_active?
      sign_out(current_user)

      redirect_to new_user_session_path, alert: 'Your account has been deactivated. Please contact your administrator'
    end

    def set_user
      @user = User.find_by(email: params[:user][:email])
    end
  end
end
