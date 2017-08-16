class HomeController < ApplicationController
	include PacketFu
	extend PacketFu

   def index
     # don't need to do anything here (too simple of an application). Usually will do work here.
   end

   def show
		@ipaddress = params[:ipaddr]

		require 'nmap/program'
		Nmap::Program.sudo_scan do |nmap|
			nmap.syn_scan = false
			nmap.service_scan = false
			nmap.os_fingerprint = false
			nmap.xml = 'scan.xml'
			nmap.verbose = true
			nmap.ports = [22, 80]
			nmap.targets = @ipaddress
		end
	end

	def pass
		load "#{Rails.root}/lib/words4.rb"
		load "#{Rails.root}/lib/words5.rb"
		load "#{Rails.root}/lib/specials.rb"
		load "#{Rails.root}/lib/numbers.rb"
		load "#{Rails.root}/lib/words4up.rb"
		load "#{Rails.root}/lib/words5up.rb"

		@pw = params[:pword]

		@c0 = params[:c0]
		@c1 = params[:c1]
		@c2 = params[:c2]
		
		#for each constraint
		if(!@c0 && !@c1 && !@c2)
			@password = dictionary4.sample + @pw
		end

		if(@c0 && !@c1 && !@c2)
			@password = dictionary4up.sample + @pw
		end
		if(!@c0 && @c1 && !@c2)
			@password = dictionary4.sample + @pw + dictionaryN.sample
		end
		if(!@c0 && !@c1 && @c2)
			@password = dictionary4.sample + dictionaryS.sample + @pw
		end

		if(@c0 && @c1 && !@c2)
			@password = dictionary4up.sample + @pw + dictionaryN.sample
		end
		if(!@c0 && @c1 && @c2)
			@password = dictionary4.sample + dictionaryS.sample + @pw + dictionaryN.sample
		end
		if(@c0 && !@c1 && @c2)
			@password = dictionary4up.sample + dictionaryS.sample + @pw
		end

		if(@c0 && @c1 && @c2)
			@password = dictionary4up.sample + dictionaryS.sample + @pw + dictionaryN.sample
		end

	end

	def upload
		require 'packetfu'
		require 'chartkick'
		@fn = params[:filename]
		@filename = @fn.original_filename
		File.open(Rails.root.join('public', @fn.original_filename), 'wb') do |file|
        file.write(@fn.read)
    	end
	end


	def sniff
	  require 'rubygems'
	  require 'packetfu'

	  @iface = params[:iface]

	end


end
