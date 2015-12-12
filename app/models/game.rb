class Game < ActiveRecord::Base
  validates_presence_of :name, :short_name
  validates_uniqueness_of :short_name

  default_scope { order(:name) }

  has_many :authorizations
  has_many :game_cache

  mount_uploader :icon, IconUploader

  attr_accessor :status, :log

  def status
    @status ||= GameManager.get_status(self)
  end

  def log
    @log ||= GameManager.get_log(self)
  end

  def to_param
    short_name
  end
end
