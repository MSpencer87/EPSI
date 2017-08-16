require 'rubygems'
require 'packetfu'

iface = ARGV[0] || "wlan1"

include PacketFu

def sniff(iface)
  num = 0
  cap = Capture.new(:iface => iface, :start => true, :promisc => false)
  
  cap.stream.each do |p|
    pkt = Packet.parse p
    if(pkt.class != InvalidPacket)
      if pkt.is_ip?
        packet_info = [pkt.ip_saddr, pkt.ip_daddr, pkt.size, pkt.proto.last]
        print num
        puts ". %-17s -> %-15s %-4d %s" % packet_info
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
      packet_info = [sniff[20..21], sniff[22..23], sniff[24..25], sniff[26..27], sniff[28..29], sniff[30..31], sniff[8..9], sniff[10..11], sniff[12..13], sniff[14..15], sniff[16..17], sniff[18..19], pkt.size, sniff[0]]
      puts ". %-2s:%-2s:%-2s:%-2s:%-2s:%-2s -> %-2s:%-2s:%-2s:%-2s:%-2s:%-2s %-4d %s !!!!!" % packet_info
      num = num + 1
    end
    #print "   "
    #puts pkt.peek

  end
end

sniff(iface)