class Game < ActiveRecord::Base
  validates_presence_of :name, :short_name, :start_script, :stop_script, :status_script
  validates_uniqueness_of :short_name

  has_many :authorizations

  mount_uploader :icon, IconUploader

  attr_accessor :status

  def get_status
    @status = GameManager.get_status(self)
    self
  end

  def to_param
    short_name
  end
end
