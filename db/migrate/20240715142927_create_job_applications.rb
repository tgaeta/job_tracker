class CreateJobApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :job_applications do |t|
      t.date :date_applied, null: false
      t.string :company_name, null: false
      t.string :method_of_contact, null: false
      t.string :email_address
      t.string :point_of_contact
      t.string :website_link
      t.string :position_type, null: false
      t.string :position_title, null: false

      t.timestamps
    end
  end
end
