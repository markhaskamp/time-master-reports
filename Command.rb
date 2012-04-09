require 'date'

class Command
  def self.create cmd
    return CmdOption.new if cmd.downcase == 'options'
    return CmdClientProjectReport.new if cmd.downcase == 'client'

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
    data_file = "#{options[:data_file]}"
    file_string = IO.read data_file

    # build array of TimeLine objects
    timelines = []
    file_lines = file_string.split("\n")
    remove_heading_row(file_lines)


    # walk through lines
    file_lines.each do |line|
      timelines.push TimeLine.new line
    end

    # get data for only this client
    timelines = 
            timelines.find_all{|timeline| timeline.time_line[CLIENT].downcase == options[:client]}

    unique_dates = get_unique_dates timelines
    last_cwday = 42;
    unique_dates.each do |date_str|
      date_time = get_datetime_for_date_str date_str
      weekday = date_time.strftime("%a")

      day_timelines = get_timeslines_for_day date_str, timelines
      total_for_day = 
              day_timelines.reduce(0) {|sum, timeline| sum + (timeline.time_line[DURATION].to_i) }

      puts "\n" if date_time.cwday < last_cwday
      puts " #{weekday}, #{date_str} - #{total_for_day}"

      last_cwday = date_time.cwday
    end
    puts "\n"
  end

  def get_datetime_for_date_str date_str
    date_parts = date_str.split("\/")
    d = DateTime.new(("20" + date_parts[2]).to_i, date_parts[0].to_i, date_parts[1].to_i)
  end

  def get_timeslines_for_day date_str, timelines
    timelines.find_all{|timeline| timeline.time_line[DATE] == date_str}
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

