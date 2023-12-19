class CreateViewChapters < ActiveRecord::Migration[7.0]
  def change
    create_table :view_chapters do |t|
      t.references :purchased_course, null: false, foreign_key: true
      t.references :chapter, null: false, foreign_key: true

      t.timestamps
    end
  end
end
