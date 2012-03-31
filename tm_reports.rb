require 'optparse'

def parse_command_line_options
  options = {}
	option_parser = OptionParser.new do |opts|
	  opts.on("-h", "--help") do
	    options[:help] = true
	  end
	
	  opts.on("-f FILE") do |data_file|
	    options[:data_file] = data_file
	  end
	
	  opts.on("--file FILE") do |data_file|
	    options[:data_file] = data_file
	  end
	end
	
	option_parser.parse!
  options
end

options = parse_command_line_options
puts options.inspect


