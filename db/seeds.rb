require "faker"

JobApplication.destroy_all
50.times do
  method_of_contact = %w[email internet_job_application recruiter].sample
  email_address = (method_of_contact == "email") ? Faker::Internet.email : nil
  website_link = (method_of_contact == "internet_job_application") ? "https://example.com/" : nil

  JobApplication.create!(
    date_applied: Faker::Date.backward(days: 30),
    company_name: Faker::Company.name,
    method_of_contact: method_of_contact,
    email_address: email_address,
    point_of_contact: Faker::Name.name,
    position_type: %w[full_time part_time internship].sample,
    position_title: Faker::Job.title,
    website_link: website_link
  )
end
