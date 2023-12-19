# frozen_string_literal: true

class ViewChapter < ApplicationRecord
  belongs_to :purchased_course
  belongs_to :chapter
end
