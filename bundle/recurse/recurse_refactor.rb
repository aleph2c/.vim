require "debugger"

class RecurseRefactor
  DefaultYamlFileName = "refactor_tokens.yaml"
  attr_reader :dir, :yaml_file, :tokens, :filters
  def initialize(spec)
    @log       = []
    @dir       = spec[:dir]
    @yaml_file = spec[:yaml_file]
    @filters   = spec[:filters]
    if @filters.nil?
      @filters = ["c","h"]
    end
    @tokens      = YAML::load(File.open(@yaml_file))

    files_of_interest do |filtered_file|
      file_lines = []
      new_lines  = []
      File.open(filtered_file, "r"){ |fp| file_lines = fp.readlines }

      tokens_of_interest do |old_token, new_token|
        new_lines = []
        file_lines.each_with_index do |line, index|
          line_number = index+1
          old_token_regex = /#{old_token}/
          if line =~ old_token_regex
            @log << "file: #{filtered_file}, line: #{line_number}, '#{old_token}' -> '#{new_token}'"
          end
          new_lines << line.gsub(old_token_regex, new_token)
        end
        file_lines = new_lines.dup
      end

      begin
      File.open(filtered_file, "w") do |fp|
        file_lines.each do |line|
          fp.puts line
        end
      end
      rescue
      end
    end
  end

  def feedback
    feedback_string = ""
    @log.each_with_index do |item, index|
      feedback_string += "%s: %s\n" % [ (index+1).to_s, item ]
    end
    feedback_string
  end

  def self.get_default_yaml_file_name
    return DefaultYamlFileName
  end
  # this is used to create an example to work from
  def self.example_output_file(path, file_name=DefaultYamlFileName)

    full_file_name = File.join(path,file_name)
    File.open( full_file_name, "w") do |fp|
      fp.puts <<ExampleYaml
---
  # add as many as you need
  old_string_1:  new_string_1
  old_string_2:  new_string_2
ExampleYaml
    end
    # add our output path to the log
    full_file_name
  end

  def files_of_interest
    @filters.each do |extension_filter|
      Dir.glob("**/*.#{extension_filter}") do |file|
        yield file
      end
    end
  end

  def tokens_of_interest
    @tokens.each do | old_token, new_token |
      yield old_token, new_token
    end
  end
end
