class AddUnemploymentClaimAndCoverLetterToJobApplications < ActiveRecord::Migration[7.1]
  def change
    add_column :job_applications, :claimed_for_unemployment, :boolean, null: false, default: false
  end
end
