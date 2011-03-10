module ApplicationHelper
  def error_messages_for(object)
    render(:partial => 'shared/error_messages', :locals => {:object => @object})
  end

  def language_selector
    if I18n.locale == :kg
      link_to image_tag("russia.gif", :size => "25x16"), url_for(:locale => 'ru')
    else
      link_to image_tag("kyrgyzstan.png", :size => "25x16"), url_for(:locale => 'kg')
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

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
