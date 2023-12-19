class JobApplication < ApplicationRecord
  belongs_to :student, class_name: "User"
  belongs_to :job
  belongs_to :employer, class_name: "User", optional: true

  validates :phone, :cover_letter, :status, presence: true
  validates :phone, uniqueness: { scope: :job }

  before_validation :set_status

  def accepted!
    self.status = 'accepted'
    self.save!
  end

  def rejected!
    self.status = 'rejected'
    self.save!
  end

  def rejected?
    status == 'rejected'
  end

  def accepted?
    status == 'accepted'
  end

  private

  def set_status
    self.status ||= 'pending_review'
  end
end
