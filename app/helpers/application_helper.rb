module ApplicationHelper
  def flash_class(type)
    case type.to_sym
    when :notice then "bg-blue-100 border-blue-500 text-blue-700"
    when :success then "bg-green-100 border-green-500 text-green-700"
    when :error then "bg-red-100 border-red-500 text-red-700"
    when :alert then "bg-yellow-100 border-yellow-500 text-yellow-700"
    else "bg-gray-100 border-gray-500 text-gray-700"
    end + " border-l-4 p-4 mb-4"
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
    if uri.scheme && !["http", "https"].include?(uri.scheme)
      "#"  # or some default safe URL
    else
      url
    end
  rescue URI::InvalidURIError
    "#"  # or some default safe URL
  end
end
