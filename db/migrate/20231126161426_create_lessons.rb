class CreateLessons < ActiveRecord::Migration[7.0]
  def change
    create_table :lessons do |t|
      t.string :title
      t.string :url
      t.string :type, null: false, default: 'Text'
      t.references :chapter, null: false, foreign_key: true

      t.timestamps
    end
  end
end
