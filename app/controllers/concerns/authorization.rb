# frozen_string_literal: true

# Authorization helpers (Uses Pundit)
#
module Authorization
  extend ActiveSupport::Concern
  include Pundit::Authorization

  included do
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  end

  protected

  def user_not_authorized
    action = request.params[:action] == 'new' ? 'create' : request.params[:action]
    flash[:alert] = "#{current_user.name} not authorized to #{action} #{request.params[:controller].titleize}."

    redirect_back(fallback_location: root_path)
  end
end
