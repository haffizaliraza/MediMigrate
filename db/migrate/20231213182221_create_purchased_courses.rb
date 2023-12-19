class CreatePurchasedCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :purchased_courses do |t|
      t.references :course, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: { to_table: :users  }
      t.json :purchased_items, default: {}
      t.string :stripe_session_id

      t.timestamps
    end
  end
end
