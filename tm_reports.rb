#!ruby
require 'optparse'
require File.dirname(__FILE__) + '/Command.rb'
require File.dirname(__FILE__) + '/TimeLine.rb'


def build_default_options
  options = {}
  options[:src_dir] = '/Users/mark/Dropbox/timemaster'
  options
end

def parse_command_line_options options
	option_parser = OptionParser.new do |opts|
    opts.banner = "print total hours by day"

	  opts.on("-f FILE") do |data_file|
	    options[:data_file] = data_file
	  end
	
	  opts.on("--file FILE") do |data_file|
	    options[:data_file] = data_file
	  end
	
	  opts.on("-r REPORT") do |report|
	    options[:report] = report
	  end
	
	  opts.on("--report REPORT") do |report|
	    options[:report] = report
	  end

	end
	
	option_parser.parse!
  options
end

options = build_default_options
parse_command_line_options options


report_run = false
if options[:report] then
  puts "report: #{options[:report]}"
  report_run = true
  cmd = Command.create options[:report]
  cmd.execute options
end
if ARGV.length > 0 then
  unless report_run then
    command_descr = ARGV[0]
    cmd = Command.create command_descr
    cmd.execute options
  end
end


