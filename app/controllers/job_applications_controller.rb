class JobApplicationsController < ApplicationController
  before_action :set_job_application, only: [:create, :update, :destroy]

  def index
    @job_applications = JobApplication.all

    if params[:search].present?
      @job_applications = @job_applications.where("company_name ILIKE ? OR position_title ILIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    end

    if params[:method_of_contact].present?
      @job_applications = @job_applications.where(method_of_contact: params[:method_of_contact])
    end

    if params[:position_type].present?
      @job_applications = @job_applications.where(position_type: params[:position_type])
    end

    @job_application_count = @job_applications.count

    @job_applications = if params[:sort].present? && params[:direction].present?
      @job_applications.order(params[:sort] => params[:direction])
    else
      @job_applications.order(date_applied: :desc)
    end

    @job_applications = @job_applications.paginate(page: params[:page], per_page: 10)

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def new
    @job_application = JobApplication.new
  end

  def create
    @job_application = JobApplication.new(job_application_params)

    respond_to do |format|
      if @job_application.save
        format.html { redirect_to job_applications_path, notice: "Job application was successfully created." }
        format.turbo_stream {
          flash.now[:notice] = "Job application was successfully created."
          render turbo_stream: [
            turbo_stream.prepend("job_applications", partial: "job_application", locals: {job_application: @job_application}),
            turbo_stream.update("flash_messages", partial: "flash_messages"),
            turbo_stream.replace("new_job_application", partial: "form", locals: {job_application: JobApplication.new})
          ]
        }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@job_application, partial: "form", locals: {job_application: @job_application}) }
      end
    end
  end

  def update
    respond_to do |format|
      if @job_application.update(job_application_params)
        format.html { redirect_to job_applications_path, notice: "Job application was successfully updated." }
        format.turbo_stream {
          flash.now[:notice] = "Job application was successfully updated."
          render turbo_stream: [
            turbo_stream.replace(@job_application, partial: "job_application", locals: {job_application: @job_application}),
            turbo_stream.update("flash_messages", partial: "flash_messages")
          ]
        }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@job_application, partial: "form", locals: {job_application: @job_application}) }
      end
    end
  end

  def destroy
    @job_application.destroy
    respond_to do |format|
      format.html { redirect_to job_applications_url, notice: "Job application was successfully deleted." }
      format.turbo_stream {
        flash.now[:notice] = "Job application was successfully deleted."
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
  end

  def job_application_params
    params.require(:job_application).permit(:date_applied, :company_name, :method_of_contact, :email_address, :point_of_contact, :website_link, :position_type, :position_title)
  end
end
