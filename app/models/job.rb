class Job < ApplicationRecord
  include Sluggish

  TYPES = ['Full Time', 'Part time']

  has_many :job_applications, dependent: :restrict_with_error
  has_rich_text :description

  validates :title, presence: true

  before_create :set_slug

  def display_status
    published? ? 'Published' : 'Not Published'
  end
end
