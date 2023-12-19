class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  STATUSES = { in_active: 0, active: 1 }.freeze

  enum status: STATUSES

  def admin_user?
    false
  end

  def employer?
    false
  end

  def student?
    false
  end

  def self.fetch_descendants
    AdminUser.none
    Employer.none
    Student.none
    descendants.reduce({}) { |total, descendant| total.update(descendant.to_s.titleize => descendant.to_s) }
  end
end
