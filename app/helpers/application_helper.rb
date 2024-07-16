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
    direction = (column.to_s == params[:sort] && params[:direction] == "asc") ? "desc" : "asc"
    link_to name,
      request.params.merge(sort: column, direction: direction),
      class: "text-gray-600 hover:text-gray-900",
      data: {
        turbo_frame: "job_applications_table",
        turbo_action: "replace"
      }
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
