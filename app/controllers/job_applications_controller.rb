class JobApplicationsController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :set_job_application, only: [:edit, :update, :destroy]

  def index
    @job_applications = filter_and_sort_job_applications
    @job_application_count = @job_applications.count
    @job_applications = @job_applications.paginate(page: params[:page], per_page: 10)

    @pagination_info = {
      current_page: @job_applications.current_page,
      total_pages: @job_applications.total_pages,
      offset: @job_applications.offset,
      length: @job_applications.length,
      total_entries: @job_applications.total_entries
    }

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def new
    @job_application = JobApplication.new
    respond_to do |format|
      format.html
      format.turbo_stream { render turbo_stream: turbo_stream.replace("new_job_application", partial: "form", locals: {job_application: @job_application, title: "New"}) }
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.turbo_stream { render turbo_stream: turbo_stream.replace(dom_id(@job_application), partial: "form", locals: {job_application: @job_application, title: "Edit"}) }
    end
  end

  def create
    @job_application = JobApplication.new(job_application_params)

    respond_to do |format|
      if @job_application.save
        format.html { redirect_to root_path, success: "Job application was successfully created." }
        format.turbo_stream do
          render turbo_stream: turbo_stream.redirect_advanced(root_path)
          flash[:success] = "Job application was successfully created."
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("new_job_application", partial: "form", locals: {job_application: @job_application, title: "New"}),
            turbo_stream.update("flash_messages", partial: "flash_messages")
          ]
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @job_application.update(job_application_params)
        format.html { redirect_to root_path, success: "Job application was successfully updated." }
        format.turbo_stream do
          render turbo_stream: turbo_stream.redirect_advanced(root_path)
          flash[:success] = "Job application was successfully updated."
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @job_application.destroy
    respond_to do |format|
      format.html { redirect_to root_path, success: "Job application was successfully deleted." }
      format.turbo_stream {
        flash.now[:success] = "Job application was successfully deleted."
        render turbo_stream: [
          turbo_stream.remove(@job_application),
          turbo_stream.update("job_application_count", JobApplication.count),
          turbo_stream.update("flash_messages", partial: "flash_messages")
        ]
      }
    end
  end

  private

  def set_job_application
    @job_application = JobApplication.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Job application not found."
  end

  def job_application_params
    params.require(:job_application).permit(:date_applied, :company_name, :method_of_contact, :email_address, :point_of_contact, :website_link, :position_type, :position_title)
  end

  def filter_and_sort_job_applications
    job_applications = JobApplication.all

    job_applications = job_applications.search(params[:search]) if params[:search].present?
    job_applications = job_applications.by_method_of_contact(params[:method_of_contact]) if params[:method_of_contact].present?
    job_applications = job_applications.by_position_type(params[:position_type]) if params[:position_type].present?

    sort_column = sort_column(params[:sort])
    sort_direction = sort_direction(params[:direction])

    if sort_column == "created_at" || params[:sort].blank?
      # If sorting by created_at or no sorting specified, always use desc order
      job_applications.order(created_at: :desc)
    else
      # For other columns, use the specified sort direction
      job_applications.order(sort_column => sort_direction)
    end
  end

  def sort_column(column)
    %w[date_applied company_name position_title created_at].include?(column) ? column : "created_at"
  end

  def sort_direction(direction)
    %w[asc desc].include?(direction) ? direction : "desc"
  end
end
