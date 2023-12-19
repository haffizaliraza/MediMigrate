# frozen_string_literal: true

class Video < Lesson
  has_one_attached :file

  def video?
    true
  end
end
