FactoryBot.define do
  factory :job_application do
    claimed_for_unemployment { false }
    company_name { "Example Company" }
    date_applied { Date.new(2023, 1, 1) }
    email_address { "example@example.com" }
    location { "remote" }
    method_of_contact { "email" }
    point_of_contact { "John Doe" }
    position_title { "Software Engineer" }
    position_type { "full_time" }
    status { "interviewing" }

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
