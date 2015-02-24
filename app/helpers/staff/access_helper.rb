module Staff::AccessHelper

  def menu_link(name, path)
    string = "<li>"
    string +=  link_to(name, path,
                       :onmouseover => "writeText('status', 'Manage #{name}');",
                       :onmouseout  => "writeText('status', '');")
    string += "</li>"
    string.html_safe
  end

  def status_tag(boolean, options={})
      options[:true]        ||= ''
      options[:true_class]  ||= 'status true'
      options[:false]       ||= ''
      options[:false_class] ||= 'status false'

      if boolean
        content_tag(:span, options[:true], :class => options[:true_class])
      else
        content_tag(:span, options[:false], :class => options[:false_class])
      end
    end

end
