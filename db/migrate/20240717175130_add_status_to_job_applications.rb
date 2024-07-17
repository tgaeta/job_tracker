class AddStatusToJobApplications < ActiveRecord::Migration[7.1]
  def change
    add_column :job_applications, :status, :string, null: false, default: "no response"
    add_check_constraint :job_applications, "status IN ('interviewing', 'no response', 'hired', 'not hired', 'job offer')", name: "check_valid_status"
  end
end
