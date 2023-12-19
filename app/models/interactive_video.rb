# frozen_string_literal: true

class InteractiveVideo < Lesson
  ALLOWED_LINK_EXTENSIONS = %r{\A(?:https?://)?(?:www\.)?zoom\.us/(?:j/|my/)?(?:[\d?]{9,})\z}.freeze

  validates :url, presence: true, format: ALLOWED_LINK_EXTENSIONS

  def interactive_video?
    true
  end
end
