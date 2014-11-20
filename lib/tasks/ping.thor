class Ping < Thor
  desc 'ping', 'Reply with pong'
  def ping
    puts 'PONG'
  end
end
