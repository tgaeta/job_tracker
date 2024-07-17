require "test_helper"

class JobApplicationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @job_application = create(:job_application)
  end

  test "should get index" do
    get job_applications_url
    assert_response :success
  end

  test "should get new" do
    get new_job_application_url
    assert_response :success
  end

  test "should create job_application" do
    assert_difference("JobApplication.count") do
      post job_applications_url, params: {job_application: attributes_for(:job_application)}
    end

    assert_redirected_to root_url
  end

  test "should get edit" do
    get edit_job_application_url(@job_application)
    assert_response :success
  end

  test "should update job_application" do
    patch job_application_url(@job_application), params: {job_application: {company_name: "Updated Company"}}
    assert_redirected_to root_url
    @job_application.reload
    assert_equal "Updated Company", @job_application.company_name
  end

  test "should destroy job_application" do
    assert_difference("JobApplication.count", -1) do
      delete job_application_url(@job_application)
    end

    assert_redirected_to root_url
  end

  test "should filter job_applications" do
    create(:job_application_phone)
    create(:job_application, :with_website)
    create(:job_application, :hired)

    get job_applications_url, params: {method_of_contact: "email"}
    assert_response :success
    assert_equal 1, @controller.view_assigns["job_applications"].count

    get job_applications_url, params: {method_of_contact: "internet_job_application"}
    assert_response :success
    assert_equal 1, @controller.view_assigns["job_applications"].count

    get job_applications_url, params: {status: "hired"}
    assert_response :success
    assert_equal 1, @controller.view_assigns["job_applications"].count
  end

  test "should search job_applications" do
    create(:job_application_unique)

    get job_applications_url, params: {search: "Unique"}
    assert_response :success
    assert_equal 1, @controller.view_assigns["job_applications"].count
  end

  test "should sort job_applications" do
    create(:job_application_jan_2)
    create(:job_application_jan_1)

    get job_applications_url, params: {sort: "date_applied", direction: "asc"}
    assert_response :success
    assert_equal Date.new(2023, 1, 1), @controller.view_assigns["job_applications"].first.date_applied

    get job_applications_url, params: {sort: "date_applied", direction: "desc"}
    assert_response :success
    assert_equal Date.new(2023, 1, 2), @controller.view_assigns["job_applications"].first.date_applied
  end
end
