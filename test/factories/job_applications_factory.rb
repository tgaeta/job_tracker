FactoryBot.define do
  factory :job_application do
    date_applied { Date.new(2023, 1, 1) }
    company_name { "Example Company" }
    method_of_contact { "email" }
    position_type { "full_time" }
    position_title { "Software Engineer" }
    claimed_for_unemployment { false }
    status { "interviewing" }
    email_address { "example@example.com" }
    point_of_contact { "John Doe" }

    trait :with_website do
      method_of_contact { "internet_job_application" }
      website_link { "https://example.com/jobs" }
    end

    trait :claimed do
      claimed_for_unemployment { true }
    end

    trait :hired do
      status { "hired" }
    end
  end
end
