class CreateJobApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :job_applications do |t|
      t.string :status
      t.text :cover_letter
      t.string :phone
      t.references :job, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: { to_table: :users  }

      t.timestamps
    end
  end
end
