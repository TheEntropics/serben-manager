class GameCache < ActiveRecord::Base
  ELAPSE_TIME = 1.minute

  belongs_to :game

  serialize :status, JSON

  scope :not_elapsed, ->{ where('created_at >= ?', DateTime.now - ELAPSE_TIME) }

  def self.get_cache(game)
    cache = GameCache.where(game: game).not_elapsed.last
    cache && (cache.invalidated ? nil : cache)
  end

  def invalidate!
    update(invalidated: true)
  end
end
