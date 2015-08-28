class Game < ActiveRecord::Base
  validates_presence_of :name, :short_name, :start_script, :stop_script, :status_script
  validates_uniqueness_of :short_name

  attr_accessor :status

  def get_status
    @status = { online: rand < 0.5 }
    @status['Uptime'] = '1h' if rand < 0.8
    @status['Players'] = rand(10) if rand < 0.3
    self
  end

  def to_param
    short_name
  end
end
