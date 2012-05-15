module ApplicationHelper
  
  def title
    base_title = "Storehouse"
    if @title.nil?
      base_title
    else
      "#{base_title}: #{@title}"
    end
  end

  def heading
    if @heading.nil?
      if @title.nil?
        ""
      else
        @title.upcase
      end
    else
      @heading.upcase
    end
  end
  
  def subheading
    if @subheading.nil?
      heading
    else
      @subheading.upcase
    end
  end
  
  def flash_message(flash)
    if flash.any? 
      inner_content = content_tag(:h3, flash[:heading])
      inner_content_main = content_tag :ul do
        flash.collect {|key, value| concat(content_tag(:li, value))  unless key == :heading }
      end
      
      inner_content << inner_content_main
      content_tag(:div, inner_content, :id => (flash.key?(:error) ? "flash_error" : "flash_info"), :class => "flash_message")
    end
  end
end
