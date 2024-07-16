class JobApplication < ApplicationRecord
  validates :date_applied, :company_name, :method_of_contact, :position_type, :position_title, presence: true
  validates :email_address, presence: true, if: -> { method_of_contact == 'email' }
  validates :point_of_contact, presence: true, if: -> { ['email', 'phone', 'recruiter', 'other'].include?(method_of_contact) }
  validates :website_link, presence: true, if: -> { method_of_contact == 'internet job application' }

  enum method_of_contact: { email: 'email', phone: 'phone', internet_job_application: 'internet job application', recruiter: 'recruiter', other: 'other' }
  enum position_type: { full_time: 'full-time', part_time: 'part-time', internship: 'internship' }
end
