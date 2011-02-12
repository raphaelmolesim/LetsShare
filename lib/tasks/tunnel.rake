namespace "tunnel" do
  desc "Start a reverse tunnel from FACEBOOK_CONFIG['host'] to localhost"
  task "start" => "environment" do
    puts "Tunneling #{FACEBOOK_CONFIG['host']}:#{FACEBOOK_CONFIG['port']} to 0.0.0.0:3000"
    exec "ssh -nNT -g -R *:#{FACEBOOK_CONFIG['port']}:0.0.0.0:3000 #{FACEBOOK_CONFIG['host']}"
  end

  desc "Check if reverse tunnel is running"
  task "status" => "environment" do
    if `ssh #{FACEBOOK_CONFIG['host']} netstat -an |
        egrep "tcp.*:#{FACEBOOK_CONFIG['port']}.*LISTEN" | wc`.to_i > 0
      puts "Seems ok"
    else
      puts "Down"
    end
  end
end