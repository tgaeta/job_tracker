class JobApplication < ApplicationRecord
  attribute :status, :string
  attribute :location, :string

  validates :date_applied, :company_name, :method_of_contact, :position_type, :position_title, presence: true
  validates :email_address, presence: true, if: -> { method_of_contact == "email" }
  validates :point_of_contact, presence: true, if: -> { ["email", "phone", "recruiter", "other"].include?(method_of_contact) }
  validates :website_link, presence: true, if: -> { method_of_contact == "internet_job_application" }
  validates :website_link, url: {
    allow_blank: true,
    schemes: ["http", "https"],
    no_local: true,
    public_suffix: true
  }
  validates :claimed_for_unemployment, inclusion: {in: [true, false]}
  validates :status, inclusion: {in: %w[hired interviewing job_offer no_response not_hired]}
  validates :location, inclusion: {in: %w[hybrid in_office remote]}

  enum method_of_contact: {
    email: "email",
    internet_job_application: "internet job application",
    other: "other",
    phone: "phone",
    recruiter: "recruiter"
  }
  enum position_type: {
    full_time: "full_time",
    internship: "internship",
    part_time: "part_time"
  }
  enum status: {
    hired: "hired",
    interviewing: "interviewing",
    job_offer: "job offer",
    no_response: "no response",
    not_hired: "not hired"
  }
  enum location: {
    hybrid: "hybrid",
    in_office: "in office",
    remote: "remote"
  }

  scope :by_location, ->(location) { where(location: location) }
  scope :by_method_of_contact, ->(method) { where(method_of_contact: method) }
  scope :by_position_type, ->(type) { where(position_type: type) }
  scope :by_status, ->(status) { where(status: status) }
  scope :claimed_for_unemployment, -> { where(claimed_for_unemployment: true) }
  scope :not_claimed_for_unemployment, -> { where(claimed_for_unemployment: false) }
  scope :search, ->(query) {
    where("company_name ILIKE :query OR
           position_title ILIKE :query OR
           email_address ILIKE :query OR
           point_of_contact ILIKE :query OR
           website_link ILIKE :query OR
           location ILIKE :query OR
           status ILIKE :query", query: "%#{query}%")
  }
end
