require 'rubygems'
require 'packetfu'

# Set interface (Default: en0)
iface = ARGV[0] || "wlan1"

#cap = PacketFu::Capture.new(:iface => iface, :start => true, :promisc => true)
#cap.stream.each do |p|
#  pkt = PacketFu::Packet.parse(p)
  #if pkt.is_ip? and pkt.is_tcp? 
    #if pkt.tcp_flags.syn == 1 and pkt.tcp_flags.ack == 0
   #   print "Source Addr: #{pkt.ip_saddr}\n"
      #print "Source Addr: #{pkt.ip6_saddr}\n"
   #   print "Source MAC: #{pkt.eth_saddr}\n"
   #   print "Destination Addr: #{pkt.ip_daddr}\n"
   #   print "Destination Addr: #{pkt.eth_daddr} "
    #  print "Size: #{pkt.size}\n"      
    #end
  #end
  #if !pkt.is_tcp?
    #if pkt.eth_saddr != nil
   #   print "Source MAC: #{pkt.eth_saddr}\n"
   #   print "Destination Addr: #{pkt.eth_daddr} "
   #   print "Size: #{pkt.size}\n"
    #end
  #end
#  print num
#  print ". Size: #{pkt.size}\n"
#  num = num + 1

#end

include PacketFu

def sniff(iface)
  num = 0
  cap = Capture.new(:iface => iface, :start => true)
  cap.stream.each do |p|
    pkt = Packet.parse p
    if pkt.is_ip?
      next if pkt.ip_saddr == Utils.ifconfig(iface)[:ip_saddr]
      packet_info = [pkt.ip_saddr, pkt.ip_daddr, pkt.size, pkt.proto.last]
      print num
      puts ". %-15s -> %-15s %-4d %s" % packet_info
      num = num + 1
    end
    if !pkt.is_ip?
      packet_info = [pkt.eth_saddr, pkt.eth_daddr, pkt.size, pkt.proto.last]
      print num 
      puts ". %-15s -> %-15s %-4d %s" % packet_info
      num = num + 1
    end
  end
end

sniff(iface)












require 'rubygems'
require 'packetfu'

iface = ARGV[0] || "wlan1"

include PacketFu

def sniff(iface)
  num = 0
  cap = Capture.new(:iface => iface, :start => true)
  cap.stream.each do |p|
    pkt = Packet.parse p

    if(pkt.class != InvalidPacket)
      if pkt.is_ip?
        #next if pkt.ip_saddr == Utils.ifconfig(iface)[:ip_saddr]
          packet_info = [pkt.ip_saddr, pkt.ip_daddr, pkt.size, pkt.proto.last]
          print num
          puts ". %-15s -> %-15s %-4d %s" % packet_info
          num = num + 1
      #end
      else
      #if !pkt.is_ip?
        packet_info = [pkt.eth_saddr, pkt.eth_daddr, pkt.size, pkt.proto.last]
        print num 
        puts ". %-15s -> %-15s %-4d %s" % packet_info
        num = num + 1
      end
    else
        print num
        print ". "
        puts pkt.size
        puts pkt.class
        num = num + 1
    end

  end
end

sniff(iface)

















    if(pkt.class != InvalidPacket)
      if pkt.is_ip?
        packet_info = [pkt.ip_saddr, pkt.ip_daddr, pkt.size, pkt.proto.last]
        print num
        puts ". %-15s -> %-15s %-4d %s" % packet_info
        num = num + 1
      else
        packet_info = [pkt.eth_saddr, pkt.eth_daddr, pkt.size, pkt.proto.last]
        print num 
        puts ". %-15s -> %-15s %-4d %s" % packet_info
        num = num + 1
      end
    else
      print num
      sniff = pkt.peek
      packet_info = [sniff[20..21], sniff[22..23], sniff[24..25], sniff[26..27], sniff[28..29], sniff[30..31], sniff[8..9], sniff[10..11], sniff[12..13], sniff[14..15], sniff[16..17], sniff[18..19], packet.size, sniff[0]]
      puts ". %-2s:%-2s:%-2s:%-2s:%-2s:%-2s -> %-2s:%-2s:%-2s:%-2s:%-2s:%-2s %-4d %s" % packet_info
      num = num + 1
    end










    <% require 'packetfu' %>

<%  path = Rails.root.join("public/tester1.pcap") %>

<% num = 1 %>
<% packet_array = PacketFu::PcapFile.file_to_array(path) %> 


<% packet_array.each do |pkt| %>
  <% packet = PacketFu::Packet.parse(pkt) %>
  <% if(packet.class != "InvalidPacket") %>
    <% if packet.is_ip? %>
      <% packet_info = [packet.ip_saddr, packet.ip_daddr, packet.size, packet.proto.last] %>
      <%= num %>
      <%= ". %-15s -> %-15s %-4d %s \n" % packet_info %>
      <% num = num + 1 %>
      <br>
    <% else %>
      <% packet_info = [packet.eth_saddr, packet.eth_daddr, packet.size, packet.proto.last] %>
      <%= num %>
      <%= ". \n" %>
      <%= ". %-15s -> %-15s %-4d %s" % packet_info %>
      <% num = num + 1 %>
      <br>
    <% end %>
  <% else %>
    <%= num %>
    <% sniff = packet.peek %>
    <% packet_info = [sniff[20..21], sniff[22..23], sniff[24..25], sniff[26..27], sniff[28..29], sniff[30..31], sniff[8..9], sniff[10..11], sniff[12..13], sniff[14..15], sniff[16..17], sniff[18..19], packet.size, sniff[0]] %>
    <%= ". %-2s:%-2s:%-2s:%-2s:%-2s:%-2s -> %-2s:%-2s:%-2s:%-2s:%-2s:%-2s %-4d %s \n" % packet_info %>
    <% num = num + 1 %>
    <br>
  <% end %>

<% end %>














      path = Rails.root.join("public/tester1.pcap")


    num = 1
    packet_array = PacketFu::PcapFile.file_to_array(path)

    packet_array.each do |pkt|
      packet = PacketFu::Packet.parse(pkt)  
      if(packet.class != InvalidPacket)
        if packet.is_ip?
          packet_info = [packet.ip_saddr, packet.ip_daddr, packet.size, packet.proto.last]
          print num
          puts ". %-15s -> %-15s %-4d %s" % packet_info
          num = num + 1
        else
          packet_info = [packet.eth_saddr, packet.eth_daddr, packet.size, packet.proto.last]
          print num 
          puts ". %-15s -> %-15s %-4d %s" % packet_info
          num = num + 1
        end
      else
        print num
        sniff = packet.peek
        packet_info = [sniff[20..21], sniff[22..23], sniff[24..25], sniff[26..27], sniff[28..29], sniff[30..31], sniff[8..9], sniff[10..11], sniff[12..13], sniff[14..15], sniff[16..17], sniff[18..19], packet.size, sniff[0]]
        puts ". %-2s:%-2s:%-2s:%-2s:%-2s:%-2s -> %-2s:%-2s:%-2s:%-2s:%-2s:%-2s %-4d %s" % packet_info
        num = num + 1
      end

    end



















    <% require 'packetfu' %>

<% path = Rails.root.join("public/tester1.pcap") %>
<% num = 1 %>
<% @packet_array = PacketFu::PcapFile.file_to_array(path) %>

<% @packet_array.each do |pkt| %>
  <% @packet = PacketFu::Packet.parse(pkt) %>
  <% if(@packet.class != "InvalidPacket") %>
    <% if @packet.is_ip? %>
      <% @packet_info = [@packet.ip_saddr, @packet.ip_daddr, @packet.size, @packet.proto.last] %>
      <%= num %>
      <%= ". %-15s -> %-15s %-4d %s" % @packet_info %>
      <% num = num + 1 %>
      <br>
    <% else %>
      <% @packet_info = [@packet.eth_saddr, @packet.eth_daddr, @packet.size, @packet.proto.last] %>
      <%= num %>
      <%= ". %-15s -> %-15s %-4d %s" % @packet_info %>
      <% num = num + 1 %>
      <br>
    <% end %>
  <% else %>
    <%= num %>
    <% sniff = @packet.peek %>
    <% @packet_info = [sniff[20..21], sniff[22..23], sniff[24..25], sniff[26..27], sniff[28..29], sniff[30..31], sniff[8..9], sniff[10..11], sniff[12..13], sniff[14..15], sniff[16..17], sniff[18..19], @packet.size, sniff[0]] %>
    <%= ". %-2s:%-2s:%-2s:%-2s:%-2s:%-2s -> %-2s:%-2s:%-2s:%-2s:%-2s:%-2s %-4d %s" % @packet_info %>
    <% num = num + 1 %>
    <br>
  <% end %>
<% end %>


















      path = Rails.root.join("public/tester1.pcap")


    num = 1
    @packet_array = PacketFu::PcapFile.file_to_array(path)

    @packet_array.each do |pkt|
      @packet = PacketFu::Packet.parse(pkt) 
      if(@packet.class != InvalidPacket)
        if @packet.is_ip?
          @packet_info = [@packet.ip_saddr, @packet.ip_daddr, @packet.size, @packet.proto.last]
          print num
          puts ". %-15s -> %-15s %-4d %s" % @packet_info
          num = num + 1
        else
          @packet_info = [@packet.eth_saddr, @packet.eth_daddr, @packet.size, @packet.proto.last]
          print num 
          puts ". %-15s -> %-15s %-4d %s" % @packet_info
          num = num + 1
        end
      else
        print num
        sniff = @packet.peek
        @packet_info = [sniff[20..21], sniff[22..23], sniff[24..25], sniff[26..27], sniff[28..29], sniff[30..31], sniff[8..9], sniff[10..11], sniff[12..13], sniff[14..15], sniff[16..17], sniff[18..19], @packet.size, sniff[0]]
        puts ". %-2s:%-2s:%-2s:%-2s:%-2s:%-2s -> %-2s:%-2s:%-2s:%-2s:%-2s:%-2s %-4d %s" % @packet_info
        num = num + 1
      end

    end