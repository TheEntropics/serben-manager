class GameManager
  def self.start_game(game)
    begin
      IO.popen("sudo systemctl start #{game.service_name}")
      { status: 'success' }
    rescue
      { status: 'error' }
    end
  end

  def self.stop_game(game)
    begin
      IO.popen("sudo systemctl stop #{game.service_name}")
      { status: 'success' }
    rescue
      { status: 'error' }
    end
  end

  def self.get_status(game)
    begin
      IO.popen("sudo systemctl status #{game.service_name}") do |io|
        res = io.readlines.join
        return { status: 'game not found' } unless res.include? 'loaded'
        status = /Active: ([a-zA-Z\-]+ \([a-zA-Z\-]+\))/.match(res)[1]
        return { status: status, online: true  } if res.include? 'Active: active'
        return { status: status, online: false } if res.include? 'Active: inactive'
        return { status: status, online: false } if res.include? 'Active: deactivating (stop)'
        return { status: status }
      end
    rescue
      { status: 'error' }
    end
  end

  def self.get_log(game)
    begin
      IO.popen("sudo journalctl -n20 -r --output=json --no-pager -u #{game.service_name}") do |io|
        lines = io.readlines
        lines.map do |line|
          json = JSON.parse(line)
          {
              message: json['MESSAGE'],
              date: Time.at(json['__REALTIME_TIMESTAMP'].to_i/1_000_000).to_datetime.strftime("%d/%m/%Y %H:%M:%S")
          }
        end
      end
    rescue
      nil
    end
  end
end
