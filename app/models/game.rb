class Game < ActiveRecord::Base
  validates_presence_of :name, :short_name, :start_script, :stop_script, :status_script
  validates_uniqueness_of :short_name
end
