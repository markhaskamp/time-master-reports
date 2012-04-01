class Command
  def self.create cmd
    return CmdOption.new if cmd.downcase == 'options'
    return CmdList.new if cmd.downcase == 'list'
    return CmdClientProjectReport.new if cmd.downcase == 'client_project'

    return CmdNull.new
  end
end

class CmdOption
  def to_s
    "CmdOption"
  end

  def execute options
    puts options.inspect
  end
end

class CmdList
  def to_s
    "CmdList"
  end

  def execute options
    glob_string = "#{options[:src_dir]}/*"
    puts Dir.glob(glob_string)
  end
end

class CmdClientProjectReport
  TYPE = 0
  DATE = 1
  CLIENT = 2
  PROJECT = 3
  PROJECT_CODE = 4
  DURATION = 5
  TOTAL = 6
  ATTRIBUTES = 7
  START_TIME = 8
  STOP_TIME = 9
  PURPOSE = 10

  def to_s
    "CmdClientProjectReport"
  end

  def execute options
    # slurp in file
    data_file = "#{options[:src_dir]}/#{options[:data_file]}"
    file_string = IO.read data_file

    # build array of TimeLine objects
    timelines = []
    file_lines = file_string.split("\n")
    remove_heading_row(file_lines)

    # walk through lines
    file_lines.each do |line|
      timelines.push TimeLine.new line
    end

    unique_dates = get_unique_dates timelines
    unique_dates.each do |date_str|
      # day_timelines = get_timeslines_for_day date_str
      foo = timelines.find_all{|timeline| timeline.time_line[DATE] == date_str}
      # foo is an array of timeline objects where date = a specific day
      total_for_day = foo.reduce(0) {|sum, timeline| sum + (timeline.time_line[DURATION].to_i) }
      puts "#{date_str} \t#{total_for_day}"
    end



  end

  def get_timeslines_for_day date_str, timelines
  end

  def remove_heading_row file_lines
    file_lines.shift
  end

  def get_unique_dates timelines
    unique_dates = {}
    timelines.each do |timeline|
      # puts timeline.inspect
      unique_dates[timeline.time_line[DATE]] = 1
    end

    unique_dates.keys
  end
end

class CmdNull
  def execute options
    puts "CmdNull"
  end
end

