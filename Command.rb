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

    file_lines = file_string.split("\n")
    puts file_lines.length

    line_num = 0
    # walk through lines
    file_lines.each do |line|
      unless line_num == 0 then
        fields = line.split(",")
        puts fields.length

      end
      line_num += 1
    end

  end
end

class CmdNull
  def execute options
    puts "CmdNull"
  end
end

