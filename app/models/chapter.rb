class Chapter < ApplicationRecord

  belongs_to :course
  has_many :lessons, class_name: 'Lesson', dependent: :destroy
  has_many :view_chapters, dependent: :destroy
  has_many :purchased_courses, through: :view_chapters

  accepts_nested_attributes_for :lessons, reject_if: :all_blank, allow_destroy: true

  validates :title, presence: true

  after_create :calculate_course_score

  def calculate_course_score
    self.course.purchased_courses.each do |purchased_course|
      score = ( 100 / purchased_course.course.chapters.length) * purchased_course.chapters.length
      purchased_course.update(completed_status: score, new_chapter: true )
    end
  end
end
