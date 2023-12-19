
# frozen_string_literal: true

class PurchasedCourse < ApplicationRecord

  belongs_to :course
  belongs_to :student, class_name: "User"
  has_many :view_chapters, dependent: :destroy
  has_many :chapters, through: :view_chapters

  validates :stripe_session_id, uniqueness: { scope: :course }
end
