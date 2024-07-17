require "test_helper"

class JobApplicationTest < ActiveSupport::TestCase
  def setup
    @job_application = build(:job_application)
  end

  test "valid job application" do
    assert @job_application.valid?
  end

  test "invalid without date_applied" do
    @job_application.date_applied = nil
    assert_not @job_application.valid?
    assert_not_nil @job_application.errors[:date_applied]
  end

  test "invalid without company_name" do
    @job_application.company_name = nil
    assert_not @job_application.valid?
    assert_not_nil @job_application.errors[:company_name]
  end

  test "invalid without method_of_contact" do
    @job_application.method_of_contact = nil
    assert_not @job_application.valid?
    assert_not_nil @job_application.errors[:method_of_contact]
  end

  test "invalid without position_type" do
    @job_application.position_type = nil
    assert_not @job_application.valid?
    assert_not_nil @job_application.errors[:position_type]
  end

  test "invalid without position_title" do
    @job_application.position_title = nil
    assert_not @job_application.valid?
    assert_not_nil @job_application.errors[:position_title]
  end

  test "requires email_address when method_of_contact is email" do
    @job_application.email_address = nil
    assert_not @job_application.valid?
    assert_not_nil @job_application.errors[:email_address]
  end

  test "requires website_link when method_of_contact is internet job application" do
    @job_application = build(:job_application,
      method_of_contact: "internet_job_application",
      website_link: nil)

    assert_not @job_application.valid?
    assert_includes @job_application.errors.full_messages, "Website link can't be blank"
  end

  test "validates website_link format" do
    @job_application = build(:job_application, :with_website)
    @job_application.website_link = "invalid-url"
    assert_not @job_application.valid?
    assert_not_nil @job_application.errors[:website_link]
  end

  test "validates status inclusion" do
    assert_raises(ArgumentError) do
      build(:job_application, status: "invalid_status")
    end
  end

  test "search scope" do
    create(:job_application, company_name: "Unique Company")
    create(:job_application, position_title: "Unique Position")

    assert_equal 1, JobApplication.search("Unique Company").count
    assert_equal 1, JobApplication.search("Unique Position").count
    assert_equal 2, JobApplication.search("Unique").count
  end

  test "by_method_of_contact scope" do
    create(:job_application, method_of_contact: "email")
    create(:job_application, :with_website)

    assert_equal 1, JobApplication.by_method_of_contact("email").count
    assert_equal 1, JobApplication.by_method_of_contact("internet_job_application").count
  end

  test "by_position_type scope" do
    create(:job_application, position_type: "full_time")
    create(:job_application, position_type: "part_time")

    assert_equal 1, JobApplication.by_position_type("full_time").count
    assert_equal 1, JobApplication.by_position_type("part_time").count
  end

  test "by_status scope" do
    create(:job_application, status: "interviewing")
    create(:job_application, :hired)

    assert_equal 1, JobApplication.by_status("interviewing").count
    assert_equal 1, JobApplication.by_status("hired").count
  end

  test "claimed_for_unemployment scope" do
    create(:job_application, :claimed)
    create(:job_application)

    assert_equal 1, JobApplication.claimed_for_unemployment.count
  end

  test "not_claimed_for_unemployment scope" do
    create(:job_application, :claimed)
    create(:job_application)

    assert_equal 1, JobApplication.not_claimed_for_unemployment.count
  end
end
