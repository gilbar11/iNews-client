require 'sax-machine'
require 'inews_client/settings'

class StoryEntry
  include SAXMachine
  element :string, :as => :title, :with => {:id => "title"} 
  element :string, :as => :app_id, :with => {:id => "#{Settings.config.iNEWS_Client.field_id}" }
  element :date, :as => :air_date, :with => {:id => "air-date"}
  element :p, :as => :text

  def fired?
    self.air_date != "0" && self.air_date 
  end

end
