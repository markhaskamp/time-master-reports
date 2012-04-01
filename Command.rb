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
  def to_s
    "CmdClientProjectReport"
  end

  def execute options
    # slurp in file
    data_file = "#{options[:src_dir]}/#{options[:data_file]}"
    file_string = IO.read data_file

    file_lines = file_string.split("\n")

    puts file_lines.length
  end
end

class CmdNull
  def execute options
    puts "CmdNull"
  end
end

