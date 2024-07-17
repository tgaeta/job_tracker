module JobApplicationsHelper
  def display_position_type(position_type)
    case position_type
    when "full_time" then "Full-time"
    when "part_time" then "Part-time"
    when "internship" then "Internship"
    else
      position_type
    end
  end
end
