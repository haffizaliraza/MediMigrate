# frozen_string_literal: true

# JobApplication Policy
#
class JobApplicationPolicy < ApplicationPolicy
  def index?
    admin_user? || employer?
  end

  def new?
    student?
  end

  def create?
    student?
  end

  def show?
    index?
  end

  def accept?
    index?
  end

  def reject?
    index?
  end

  def destroy?
    index?
  end
end
