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

  def status_chip_classes(status)
    base_classes = "rounded-full px-2 py-1 text-xs font-medium text-center whitespace-nowrap overflow-hidden text-ellipsis max-w-full"

    status_classes = case status.to_sym
    when :hired
      "bg-green-100 text-green-800"
    when :interviewing
      "bg-blue-100 text-blue-800"
    when :job_offer
      "bg-purple-100 text-purple-800"
    when :no_response
      "bg-yellow-100 text-yellow-800"
    when :not_hired
      "bg-red-100 text-red-800"
    else
      "bg-gray-100 text-gray-800"
    end

    "#{base_classes} #{status_classes}"
  end

  def position_type_chip_classes(position_type)
    base_classes = "rounded-full px-2 py-1 text-xs font-medium text-center whitespace-nowrap overflow-hidden text-ellipsis max-w-full"

    type_classes = case position_type.to_sym
    when :full_time
      "bg-indigo-100 text-indigo-800"
    when :part_time
      "bg-amber-100 text-amber-800"
    when :internship
      "bg-teal-100 text-teal-800"
    else
      "bg-gray-100 text-gray-800"
    end

    "#{base_classes} #{type_classes}"
  end

  def location_emoji_with_tooltip(location)
    emoji_map = {
      in_office: "🏢",
      remote: "💻",
      hybrid: "🔄"
    }

    emoji = emoji_map[location.to_sym] || "❓"
    full_text = location.to_s.humanize

    content_tag(:span, emoji, title: full_text, class: "cursor-default text-2xl")
  end

  def method_of_contact_emoji_with_tooltip(method)
    emoji_map = {
      email: "📧",
      internet_job_application: "🌐",
      other: "🗂️",
      phone: "📱",
      recruiter: "🤝"
    }

    emoji = emoji_map[method.to_sym] || "❓"
    full_text = method.to_s.humanize

    content_tag(:span, emoji, title: full_text, class: "cursor-default text-2xl")
  end
end
