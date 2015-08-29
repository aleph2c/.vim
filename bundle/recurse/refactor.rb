# To use this command line:
# ruby refactor.rb -d <path to directory> -y <path to yaml file>
dir = File.expand_path File.dirname(__FILE__)
require "debugger"
require "optparse"
require "#{dir}/recurse_refactor.rb"

# these are the Error Codes
NO_ERROR           = 0b00
NO_DIRECTORY_ERROR = 0b01
NO_YAML_FILE_ERROR = 0b10

# initialize our globals
options            = {}
output             = ""
exit_status        = NO_ERROR

# set up are parser
option_parser = OptionParser.new do |opts|
  opts.banner = "Usage: resurse_refactor.rb -d . -y tokens.yaml"

  opts.on('-d', '--directory DIRECTORY',
         'sets the directory to recurse over' ) do |directory|
    options[:directory] = directory
  end

  opts.on('-y', '--yaml YAML',
         'sets the yaml file which contains the change tokens') do |yaml_file|
    options[:yaml_file] = yaml_file
  end

  opts.on('-e', '--example PATH',
          'sets an example yaml file at the given directory') do |yaml_path|
    options[:yaml_path] = yaml_path
  end

  opts.on('-f', '--default-yaml-file',
          'outputs the default yaml file') do 
    options[:find_default_yaml_file] = true
  end
end

# parse the output
option_parser.parse!

if !(options[:yaml_path].nil?)
  exit_status = NO_ERROR
  output = RecurseRefactor.example_output_file(options[:yaml_path])
elsif( options[:find_default_yaml_file] == true )
  exit_status = NO_ERROR
  output = RecurseRefactor.get_default_yaml_file_name
else
  exit_status |= (options[:directory].nil?) ?
    NO_DIRECTORY_ERROR : NO_ERROR
  exit_status |= (options[:yaml_file].nil?) ?
    NO_DIRECTORY_ERROR : NO_ERROR

  if( exit_status == NO_ERROR )
    rr = RecurseRefactor.new(
      dir:       options[:directory],
      yaml_file: options[:yaml_file] )
    output = rr.feedback
  end
end
puts output
exit exit_status unless expand_path = NO_ERROR

