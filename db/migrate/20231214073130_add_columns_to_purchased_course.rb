class AddColumnsToPurchasedCourse < ActiveRecord::Migration[7.0]
  def change
    add_column :purchased_courses, :current_chapter, :string
    add_column :purchased_courses, :completed_status, :string, default: 0
  end
end
