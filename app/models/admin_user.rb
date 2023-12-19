# frozen_string_literal: true

# AdminUser model
#
class AdminUser < User

  def admin_user?
    true
  end
end
