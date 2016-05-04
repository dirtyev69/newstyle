module ApplicationHelper
  def seo_title(value)
    content_for(:seo_title, value + ' / ' + default_seo_title)
  end

  def seo_description(value)
    content_for(:seo_description, value)
  end

  def seo_keywords(value)
    content_for(:seo_keywords, value)
  end

  def default_seo_title
    t('default_seo_title')
  end


  def tel_to(text)
    groups = text.to_s.scan(/(?:^\+)?\d+/)
    link_to text, "tel:#{groups.join '-'}"
  end

  def render_pagination(collection, options = {})
    html = ''

    begin
      # FIXME
      if collection.next_page.present?
        html += content_tag(:div, link_to(t('more'), url_for(params.merge(:page => collection.next_page, id: collection.first.gallery.id )), :class => 'btn btn-lg', :role => 'more'), class: 'text-center')
      end
    rescue
      nil
    end

    html += paginate(collection, :options => options, :window => 2, :left => 1, :right => 1)

    content_tag(:div, html.html_safe, class: 'pagination_container', role: 'pagination')
  end

  def svg_icon(filename, options = {})
    file = File.read(Rails.root.join('app', 'assets', 'images', 'icons', "#{filename}.svg"))
    doc = Nokogiri::HTML::DocumentFragment.parse(file)
    svg = doc.at_css 'svg'

    svg['class'] = 'svg__icon'
    svg['role'] = options[:role]


    html = doc.to_html.html_safe
    html << notification(options[:badge][:count].to_i, options[:badge]) if options[:badge].present?

    content_tag(:span, html, class: "svg #{options[:class]}") + options[:text].try(:html_safe)
  end
end
