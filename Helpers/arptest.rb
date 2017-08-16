

require 'arp' 

 cache = Arp::Cache.new
  cache.each do |entry|
    puts entry.ip             # => "192.168.124.2"
    puts entry.hw_type        # => "0x1"
    puts entry.flags          # => "0x2" 
    puts entry.hw_address     # => "00:50:56:e9:27:c7" 
    puts entry.mask           # => "*"
    puts entry.device         # => "eth0" 
    puts "--------------------------------------------"
  end
