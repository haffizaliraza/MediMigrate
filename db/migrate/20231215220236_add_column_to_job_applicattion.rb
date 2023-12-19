class AddColumnToJobApplicattion < ActiveRecord::Migration[7.0]
  def change
    add_reference :job_applications, :employer, foreign_key: { to_table: :users  }, optional: true
  end
end
