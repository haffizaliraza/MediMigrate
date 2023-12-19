class AddNewChapterToPurchasedCourse < ActiveRecord::Migration[7.0]
  def change
    add_column :purchased_courses, :new_chapter, :boolean, default: false
  end
end
