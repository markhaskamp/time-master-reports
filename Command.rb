class Command
  def self.create cmd
    return CmdOption.new if cmd.downcase == 'options'
    return CmdList.new if cmd.downcase == 'list'

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

class CmdNull
  def execute options
    puts "CmdNull"
  end
end

