require 'optparse'

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
puts options.inspect
