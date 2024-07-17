class JobApplication < ApplicationRecord
  validates :date_applied, :company_name, :method_of_contact, :position_type, :position_title, presence: true
  validates :email_address, presence: true, if: -> { method_of_contact == "email" }
  validates :point_of_contact, presence: true, if: -> { ["email", "phone", "recruiter", "other"].include?(method_of_contact) }
  validates :website_link, presence: true, if: -> { method_of_contact == "internet job application" }
  validates :website_link, url: {
    allow_blank: true,
    schemes: ["http", "https"],
    no_local: true,
    public_suffix: true
  }
  validates :claimed_for_unemployment, inclusion: {in: [true, false]}

  enum method_of_contact: {email: "email", phone: "phone", internet_job_application: "internet job application", recruiter: "recruiter", other: "other"}
  enum position_type: {
    full_time: "full_time",
    part_time: "part_time",
    internship: "internship"
  }

  scope :search, ->(query) { where("company_name ILIKE ? OR position_title ILIKE ?", "%#{query}%", "%#{query}%") }
  scope :by_method_of_contact, ->(method) { where(method_of_contact: method) }
  scope :by_position_type, ->(type) { where(position_type: type) }
  scope :claimed_for_unemployment, -> { where(claimed_for_unemployment: true) }
  scope :not_claimed_for_unemployment, -> { where(claimed_for_unemployment: false) }
end
