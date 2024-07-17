module ApplicationHelper
  def flash_class(type)
    base_class = "border-l-4 p-4 mb-4 rounded-md"
    case type.to_sym
    when :notice
      "bg-blue-100 border-blue-500 text-blue-700 #{base_class}"
    when :success
      "bg-green-100 border-green-500 text-green-700 #{base_class}"
    when :error
      "bg-red-100 border-red-500 text-red-700 #{base_class}"
    when :alert
      "bg-yellow-100 border-yellow-500 text-yellow-700 #{base_class}"
    else
      "bg-gray-100 border-gray-500 text-gray-700 #{base_class}"
    end
  end

  def progress_bar_class(type)
    base_class = "rounded-md"
    case type.to_sym
    when :notice
      "bg-blue-500 #{base_class}"
    when :success
      "bg-green-500 #{base_class}"
    when :error
      "bg-red-500 #{base_class}"
    when :alert
      "bg-yellow-500 #{base_class}"
    else
      "bg-gray-500 #{base_class}"
    end
  end

  def sort_link_to(name, column)
    current_column = params[:sort]
    current_direction = params[:direction]

    is_current_column = column.to_s == current_column
    next_direction = (is_current_column && current_direction == "asc") ? "desc" : "asc"

    icon = if is_current_column
      (current_direction == "asc") ? "↑" : "↓"
    else
      ""
    end

    link_to request.params.merge(sort: column, direction: next_direction),
      class: "text-gray-600 hover:text-gray-900 inline-flex items-center",
      data: {
        turbo_frame: "job_applications_table",
        turbo_action: "replace"
      } do
      content_tag(:span, class: "flex items-center") do
        safe_join([
          content_tag(:span, name, class: "mr-1"),
          content_tag(:span, icon, class: "sort-icon")
        ])
      end
    end
  end

  def safe_url(url)
    uri = URI.parse(url)
    if uri.scheme && ["http", "https"].exclude?(uri.scheme)
      "#"
    else
      url
    end
  rescue URI::InvalidURIError
    "#"
  end
end
