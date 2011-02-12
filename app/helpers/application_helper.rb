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


end
