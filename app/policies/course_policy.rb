class CoursePolicy < ApplicationPolicy
  def index?
    admin_user? || employer?
  end

  def create?
    admin_user?
  end

  def new?
    create?
  end

  def show?
    student?
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

  def for_student?
    student?
  end

  def toggle_cart?
    student?
  end

  def checkout?
    student?
  end
end
