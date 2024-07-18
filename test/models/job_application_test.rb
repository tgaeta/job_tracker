require "test_helper"

class JobApplicationTest < ActiveSupport::TestCase
  def setup
    @job_application = build(:job_application)
  end

  test "job application is valid with valid attributes" do
    assert @job_application.valid?
  end

  test "job application is invalid without date_applied" do
    @job_application.date_applied = nil
    assert_not @job_application.valid?
    assert_not_nil @job_application.errors[:date_applied]
  end

  test "job application is invalid without company_name" do
    @job_application.company_name = nil
    assert_not @job_application.valid?
    assert_not_nil @job_application.errors[:company_name]
  end

  test "job application is invalid without method_of_contact" do
    @job_application.method_of_contact = nil
    assert_not @job_application.valid?
    assert_not_nil @job_application.errors[:method_of_contact]
  end

  test "job application is invalid without position_type" do
    @job_application.position_type = nil
    assert_not @job_application.valid?
    assert_not_nil @job_application.errors[:position_type]
  end

  test "job application is invalid without position_title" do
    @job_application.position_title = nil
    assert_not @job_application.valid?
    assert_not_nil @job_application.errors[:position_title]
  end

  test "job application requires email_address when method_of_contact is email" do
    @job_application.method_of_contact = "email"
    @job_application.email_address = nil
    assert_not @job_application.valid?
    assert_not_nil @job_application.errors[:email_address]
  end

  test "job application requires website_link when method_of_contact is internet job application" do
    @job_application.method_of_contact = "internet_job_application"
    @job_application.website_link = nil
    assert_not @job_application.valid?
    assert_includes @job_application.errors[:website_link], "can't be blank"
  end

  test "job application validates website_link format" do
    @job_application.method_of_contact = "internet_job_application"
    @job_application.website_link = "invalid-url"
    assert_not @job_application.valid?
    assert_not_nil @job_application.errors[:website_link]
  end

  test "job application validates location inclusion" do
    assert_raises(ArgumentError) do
      build(:job_application, location: "invalid_location")
    end
  end

  test "job application validates status inclusion" do
    assert_raises(ArgumentError) do
      build(:job_application, status: "invalid_status")
    end
  end

  test "search scope finds job applications by company_name or position_title" do
    create(:job_application, company_name: "Unique Company")
    create(:job_application, position_title: "Unique Position")

    assert_equal 1, JobApplication.search("Unique Company").count
    assert_equal 1, JobApplication.search("Unique Position").count
    assert_equal 2, JobApplication.search("Unique").count
  end

  test "by_method_of_contact scope finds job applications by method_of_contact" do
    JobApplication.destroy_all
    create(:job_application, method_of_contact: "email")
    create(:job_application, method_of_contact: "internet_job_application", website_link: "http://example.com")

    assert_equal 1, JobApplication.by_method_of_contact("email").count
    assert_equal 1, JobApplication.by_method_of_contact("internet_job_application").count
  end

  test "by_location scope finds job applications by location" do
    JobApplication.destroy_all
    create(:job_application, location: "remote")
    create(:job_application, location: "in_office")

    assert_equal 1, JobApplication.by_location("remote").count
    assert_equal 1, JobApplication.by_location("in_office").count
  end

  test "by_position_type scope finds job applications by position_type" do
    JobApplication.destroy_all
    create(:job_application, position_type: "full_time")
    create(:job_application, position_type: "part_time")

    assert_equal 1, JobApplication.by_position_type("full_time").count
    assert_equal 1, JobApplication.by_position_type("part_time").count
  end

  test "by_status scope finds job applications by status" do
    JobApplication.destroy_all
    create(:job_application, status: "interviewing")
    create(:job_application, status: "hired")

    assert_equal 1, JobApplication.by_status("interviewing").count
    assert_equal 1, JobApplication.by_status("hired").count
  end

  test "claimed_for_unemployment scope finds job applications claimed for unemployment" do
    JobApplication.destroy_all
    create(:job_application, claimed_for_unemployment: true)
    create(:job_application, claimed_for_unemployment: false)

    assert_equal 1, JobApplication.claimed_for_unemployment.count
  end

  test "not_claimed_for_unemployment scope finds job applications not claimed for unemployment" do
    JobApplication.destroy_all
    create(:job_application, claimed_for_unemployment: true)
    create(:job_application, claimed_for_unemployment: false)

    assert_equal 1, JobApplication.not_claimed_for_unemployment.count
  end
end
