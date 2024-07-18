class AddLocationToJobApplications < ActiveRecord::Migration[7.1]
  def change
    add_column :job_applications, :location, :string, null: false, default: "remote"
    add_check_constraint :job_applications, "location IN ('remote', 'in office', 'hybrid')", name: "check_valid_location"
  end
end
