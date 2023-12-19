class JobPolicy < ApplicationPolicy
  def index?
    admin_user? || employer?
  end

  def create?
    admin_user?
  end

  def new?
    create?
  end

  def update?
    admin_user?
  end

  def edit?
    update?
  end

  def destroy?
    admin_user?
  end

  def toggle_published?
    admin_user? || employer?
  end

  def for_student?
    student?
  end
end
