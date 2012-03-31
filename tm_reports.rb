#!ruby

require 'optparse'

def build_default_options
  options = {}
  options[:src_dir] = '/Users/mark/Dropbox/timemaster'
  options
end

def parse_command_line_options options
	option_parser = OptionParser.new do |opts|
	  opts.on("-h", "--help") do
	    options[:help] = true
	  end
	
	  opts.on("-s SRC") do |src_dir|
	    options[:src_dir] = src_dir
	  end
	
	  opts.on("--srcdir SRC") do |src_dir|
	    options[:src_dir] = src_dir
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

options = build_default_options
parse_command_line_options options

if ARGV.length > 0 then
  command = ARGV[0].downcase
  puts options.inspect if command == 'options' 

  if command == 'list' then
    glob_string = "#{options[:src_dir]}/*"
    puts Dir.glob(glob_string)
  end

end


