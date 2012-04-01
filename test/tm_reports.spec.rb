require 'rspec'
require File.dirname(__FILE__) + '/../tm_reports.rb'
require File.dirname(__FILE__) + '/../TimeLine.rb'

describe 'tm_reports' do

  describe "command line options and arguments" do
    it "default directory is '/Users/mark/Dropbox/timemaster'" do
      output = `ruby ../tm_reports.rb options`
      output.should include ':src_dir=>"/Users/mark/Dropbox/timemaster'
    end

    it "src directory can be defined with -s" do
      output = `ruby ../tm_reports.rb -s "~/foo" options`
      output.should include ':src_dir=>"~/foo'
    end
 
    it "src directory can be defined with --srcdir" do
      output = `ruby ../tm_reports.rb --srcdir "~/too" options`
      output.should include ':src_dir=>"~/too'
    end

    it "'options' command lists command line option settings" do
      output = `ruby ../tm_reports.rb -f foo -s "~/too" options`
      output.should include 'data_file=>'
      output.should include 'src_dir=>'
    end

    it "'list' lists files in source directory" do
      output = `ruby ../tm_reports.rb --srcdir "data" list`
      output.split("\n").length.should == 4
    end
  end

  describe Command do
    describe "#create" do
      it "returns a CmdOption class for 'options'" do
        (Command.create('options').to_s).should == 'CmdOption'
      end

      it "returns a CmdList class for 'list'" do
        (Command.create('list').to_s).should == 'CmdList'
      end
    end
  end
end

describe "ruby lists processing" do

  file_string = IO.read "data/report (3_31_12_2_39_pm).csv"
  file_lines = file_string.split("\n")
  file_lines.shift   # remove header row
  time_lines = []   # array of TimeLine objects
  file_lines.each do |line|
    time_lines.push TimeLine.new line
  end

  
  describe "#shift" do
    it "shifts the first element off the array" do
      file_lines.length.should == 14
      file_lines.shift;
      file_lines.length.should == 13
    end
  end

  describe TimeLine do
    describe "@time_line" do
      it "is an array" do
        time_lines[0].time_line.is_a?(Array).should == true
      end
    end
  end

  describe "uniquify time_lines by day" do
    it "11 unique dates in test data" do
      date_values = {}
      time_lines.each do |time_line|
        date_values[time_line.time_line[1]] = 1
      end

      date_values.keys.length.should == 11
    end
  end

end

