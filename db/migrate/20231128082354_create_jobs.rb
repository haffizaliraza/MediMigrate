class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :location
      t.string :job_type
      t.string :slug
      t.boolean :published

      t.timestamps
    end
  end
end
