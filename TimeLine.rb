class TimeLine
  attr_accessor :time_line
	  ndx_date     = 1
	  ndx_client   = 2
	  ndx_project  = 3
	  ndx_duration = 5

  def initialize line
    @time_line = line.split(",")
  end
end

