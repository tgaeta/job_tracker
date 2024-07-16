class CustomPaginationRenderer < WillPaginate::ActionView::LinkRenderer
  def to_html
    html = pagination.map do |item|
      send(item)
    end.compact.join(@options[:link_separator])

    @options[:container] ? html_container(html) : html
  end

  def container_attributes
    super.except(:first_label, :last_label)
  end

  def pagination
    [:previous_page, :next_page]
  end

  def previous_page
    num = @collection.current_page > 1 && @collection.current_page - 1
    previous_or_next_page(num, @options[:previous_label], 'previous_page')
  end

  def next_page
    num = @collection.current_page < total_pages && @collection.current_page + 1
    previous_or_next_page(num, @options[:next_label], 'next_page')
  end

  def previous_or_next_page(page, text, classname)
    if page
      link(text, page, class: @options["#{classname}_class"])
    end
  end
end
