module BottlesHelper

  def quantity_field(f, id, uri)
    # If this is a new bottle with no id and we are not on the search page the display the quantity field
    if id.blank? && (uri =~ /search/).nil?
      return "<div class='field'>#{f.label :quantity, :class => 'round'}:&nbsp;#{f.text_field :quantity}</div>"
    end
  end
  
  def date_received_field(f, id, uri, date_field)
    if id.blank?
      return "<div class='field'>#{f.label :date_received, :class => 'round'}:&nbsp;#{f.text_field(:date_received)}</div>"
    else
      return "<div class='field'>#{f.label :date_received, :class => 'round'}:&nbsp;#{date_field}</div>"
    end
  end
  
  def date_retired_at(date_field)
    return date_field.blank? ? "" : date_field.strftime("%Y-%m-%d")
  end
  
  def substance_input(bottle)
    if bottle.errors[:substance_id].empty?
      return content_tag(:span, text_field_tag(:substance, bottle.substance.nil? ? '' : bottle.substance.name), :class => 'ui-widget')
    else
      return content_tag(:div, content_tag(:span, text_field_tag(:substance, bottle.substance.nil? ? '' : bottle.substance.name), :class => 'ui-widget'), :class=> 'field_with_errors')
    end
  end
end
