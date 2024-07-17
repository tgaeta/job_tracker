module TurboStreamActionsHelper
  # render turbo_stream: turbo_stream.redirect_advanced(projects_path)
  def redirect_advanced(url)
    turbo_stream_action_tag :redirect_advanced, url: url
  end
end

Turbo::Streams::TagBuilder.prepend(TurboStreamActionsHelper)
