class Course < ApplicationRecord
  enum status: [ :draft, :publish ], _scopes: false

  has_many :chapters, dependent: :destroy
  accepts_nested_attributes_for :chapters, reject_if: :all_blank, allow_destroy: true
  has_many :lessons, through: :chapters
  accepts_nested_attributes_for :lessons, reject_if: :all_blank, allow_destroy: true

  has_many :cart_items, dependent: :destroy
  has_many :students, through: :cart_items
  has_many :purchased_courses, dependent: :restrict_with_error

  has_rich_text :description

  validates :status, presence: true
end
