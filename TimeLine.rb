class TimeLine
  attr_accessor :time_line
  ndx_date     = 1
  ndx_client   = 2
  ndx_project  = 3
  ndx_duration = 5

  def initialize line
    @time_line = line.split(",")
  end

  def get_unique_dates
      date_values = {}
      time_lines.each do |time_line|
        date_values[time_line.time_line[1]] = 1
      end

      date_values.keys
  end
end

