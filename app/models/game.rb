class Game < ActiveRecord::Base
  validates_presence_of :name, :short_name
  validates_uniqueness_of :short_name

  default_scope { order(:name) }

  has_many :authorizations
  has_many :game_cache

  mount_uploader :icon, IconUploader

  attr_accessor :status

  def get_status(use_cache = true)
    # cache = GameCache.get_cache(self)
    # if cache && use_cache
    #   @status = cache.status.symbolize_keys
    #   Rails.logger.info("Game status from cache")
    #   Rails.logger.debug @status.inspect
    # else
    #   @status = GameManager.get_status(self)
    #   GameCache.create(game: self, status: @status)
    #   Rails.logger.debug @status.inspect
    # end
    @status = GameManager.get_status(self)
    self
  end

  def to_param
    short_name
  end
end
