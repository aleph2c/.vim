require "debugger"
class ExampleClass
  def initialize( message="hello world" )
    @message = message
  end
  def express
    puts @message
  end
  def testing_endwise
    puts "OMG it works!!!"
  end
end
ec = ExampleClass.new()
puts ec.express()
puts ec.testing_endwise

