class GameManager
  def self.start_game(game)
    status = {status: 'error'}

    Rails.logger.info "Executing command: #{game.start_script}"
    IO.popen(game.start_script) do |f|
      output = f.readlines(nil)[0]
      result = JSON.parse(output, symbolize_names: true) rescue {}
      result[:status] = 'unknown' if result[:status] == nil
      status = result
    end rescue nil
    status
  end

  def self.stop_game(game)
    status = {status: 'error'}

    Rails.logger.info "Executing command: #{game.start_script}"
    IO.popen(game.stop_script) do |f|
      output = f.readlines(nil)[0]
      result = JSON.parse(output, symbolize_names: true) rescue {}
      result[:status] = 'unknown' if result[:status] == nil
      status = result
    end rescue nil
    status
  end

  def self.get_status(game)
    status = { online: 'error' }

    Rails.logger.info "Executing command: #{game.start_script}"
    IO.popen(game.status_script) do |f|
      output = f.readlines(nil)[0]
      result = JSON.parse(output, symbolize_names: true) rescue { online: 'error' }
      result[:online] = 'unknown' if result[:online] == nil
      status = result
    end rescue nil
    status
  end
end
