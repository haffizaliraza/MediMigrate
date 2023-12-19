# frozen_string_literal: true

class Lesson < ApplicationRecord
  belongs_to :chapter

  validates :title, presence: true

  has_rich_text :content

  def text?
    false
  end

  def video?
    false
  end

  def interactive_video?
    false
  end

  before_validation :validate_lesson

  private

  def validate_lesson
    case type
    when 'Text'
      self.url = ''
    when 'Video'
      self.content = ActionText::Content.new("<h1>Lesson Type is Video!</h1>")
    when 'InteraciveVideo'
      self.content = ActionText::Content.new("<h1>Lesson Type is Zoom!</h1>")
    end
  end
end
