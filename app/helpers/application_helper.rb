# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def rounded_start
    haml = "%b{:class=>'b1'}
%b{:class=>'b2'}
%b{:class=>'b3'}
%b{:class=>'b4'}" 
    Haml::Engine.new(haml).to_html
  end
  
  def rounded_stop
    haml = "%b{:class=>'b4'}
%b{:class=>'b3'}
%b{:class=>'b2'}
%b{:class=>'b1'}"
    Haml::Engine.new(haml).to_html
  end
  
  def flash_div *keys
    keys.collect { |key| content_tag(:div, flash[key], :class => "flash #{key}") if flash[key] }.join
  end
  
  def print_quotes(type)
    haml =  type==1 ? "%img{:src=>'/images/open_quote.png'}" : "%img{:src=>'/images/close_quote.png'}"
    Haml::Engine.new(haml).to_html
  end

end
