module ApplicationHelper
  def error_messages_for(object)
    render(:partial => 'shared/error_messages', :locals => {:object => @object})
  end

  def language_selector
    if I18n.locale == :en
      link_to "Ru", url_for(:locale => 'ru')
    else
      link_to "En", url_for(:locale => 'en')
    end
  end

  def display_date(input_date)
    return input_date.strftime("%d %B %Y")
  end

  def short_date(input_date)
    return input_date.strftime("%d %m %Y - %X")
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
