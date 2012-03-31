require 'rspec'
# require File.dirname(__FILE__) + '/../lib/Greed_RulesEngine.rb'

describe 'tm_reports' do
 # before (:each) do
 #    @g = Greed.new
 # end
 # after (:each) do
 #    @g = nil
 #    @test_vals = []
 # end

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
      puts output
      output.split("\n").length.should == 4
    end
  end
end
