class GameManager
  def self.start_game(game)
    begin
      IO.popen("sudo systemctl start #{game.service_name}")
      GameCache.get_cache(game).try :invalidate!
      { status: 'success' }
    rescue
      { status: 'error' }
    end
  end

  def self.stop_game(game)
    begin
      IO.popen("sudo systemctl stop #{game.service_name}")
      GameCache.get_cache(game).try :invalidate!
      { status: 'success' }
    rescue
      { status: 'error' }
    end
  end

  def self.get_status(game)
    begin
      IO.popen("sudo systemctl status #{game.service_name}") do |io|
        res = io.readlines.join
        return { status: 'error' } unless res.include? 'loaded'
        return { online: true }    if res.include? 'Active: active (running)'
        return { online: false }   if res.include? 'Active: inactive (dead)'
        return { status: 'error' }
      end
    rescue
      { status: 'error' }
    end
  end
end
