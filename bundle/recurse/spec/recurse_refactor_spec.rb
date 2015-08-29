# bowling_spec.rb
dir = File.expand_path File.dirname(__FILE__)
require 'debugger'
require "#{dir}/../recurse_refactor"

SOME_CODE = "
// code
//
// bob
// ray
// bill
"

describe RecurseRefactor, "#score" do
  before(:all) do
    @c_file_name = "#{dir}/dir_level_1/dir_level_2/file_at_bottom_of_dir_level_2.c"
    @h_file_name = "#{dir}/dir_level_1/dir_level_2/file_at_bottom_of_dir_level_2.h"
    @other_file_name = "#{dir}/dir_level_1/dir_level_2/file_at_bottom_of_dir_level_2.other"
    @refactor_spec_yaml_file = "#{dir}/recurse_refactor.yaml"
    [ @c_file_name, @h_file_name ].each do |fn|
      fp = File.open(fn, "w")
      fp.puts SOME_CODE
      fp.close
    end

    [ @c_file_name, @h_file_name, @refactor_spec_yaml_file ].each do |fn|
      puts @c_file_name
      fp = File.open(fn, "r")
      fp.readlines.each{|line| puts line }
      fp.close
      puts "--"
    end
    @rr = RecurseRefactor.new(
            dir:  dir,
            yaml_file: @refactor_spec_yaml_file )
  end
  
  # Adding a comment
  it "have the correct directory" do
    @rr.dir.should eq(dir)
  end

  it "should have the correct yaml file" do
    @rr.yaml_file.should eq(@refactor_spec_yaml_file)
  end
  
  it "should parse the yaml file into a tokens" do
    @rr.tokens.should == {
      "bob"=>"mary",
      "ray"=>"suzy",
      "bill"=>"megan"
    }
  end

  it "should have 'c' and 'h' filters by default" do
    @rr.filters.include?("c").should eq(true)
    @rr.filters.include?("h").should eq(true)
  end

  it "should have recursed_through_the_directory and change all c and h files" do
    new_tokens = @rr.tokens.values
    new_tokens.should eq(["mary", "suzy", "megan"])

    c_file_lines     = File.open(@c_file_name, "r")
    h_file_line      = File.open(@h_file_name, "r")
    other_file_lines = File.open(@other_file_name, "r")

    token_test = ->(file, _new_tokens, should_match ){
      _new_tokens.each do |token|
        match = false
        lines = File.open(file, "r").readlines
        lines.each do |line|
          if line =~ /#{token}/
            match = true | match
            break
          end
        end
        match.should eq(should_match)
      end
    }
    token_test.call(@c_file_name, new_tokens, true )
    token_test.call(@h_file_name, new_tokens, true )
    token_test.call(@other_file_name, new_tokens, false )
  end

  it "should provide a meaningful feedback string" do
    feedback = @rr.feedback
    feedback.should_not eq(nil)
    feedback.should == <<OUTPUT
1: file: spec/dir_level_1/dir_level_2/file_at_bottom_of_dir_level_2.c, line: 4, 'bob' -> 'mary'
2: file: spec/dir_level_1/dir_level_2/file_at_bottom_of_dir_level_2.c, line: 5, 'ray' -> 'suzy'
3: file: spec/dir_level_1/dir_level_2/file_at_bottom_of_dir_level_2.c, line: 6, 'bill' -> 'megan'
4: file: spec/dir_level_1/dir_level_2/file_at_bottom_of_dir_level_2.h, line: 4, 'bob' -> 'mary'
5: file: spec/dir_level_1/dir_level_2/file_at_bottom_of_dir_level_2.h, line: 5, 'ray' -> 'suzy'
6: file: spec/dir_level_1/dir_level_2/file_at_bottom_of_dir_level_2.h, line: 6, 'bill' -> 'megan'
OUTPUT
  end

end
