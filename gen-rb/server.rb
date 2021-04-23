$:.push('gen-rb')
$:.unshift '../../lib/rb/lib'

require 'thrift'

require 'calculadora'
require 'calculadora_types'

class CalculatorHandler
  def initialize()
    @log = {}
  end

  def ping()
    puts "ping()\n"
  end

  def suma(n1, n2)
    result = n1 + n2
    print "#{n1} + #{n2} = #{result}\n"

    return result
  end

  def resta(n1, n2)
    result = n1 - n2
    print "#{n1} - #{n2} = #{result}\n"

    return result
  end

  def getStruct(key)
    print "getStruct(", key, ")\n"
    return @log[key]
  end

  def zip()
    print "zip\n"
  end

end

handler = CalculatorHandler.new()
processor = Calculadora::Processor.new(handler)
transport = Thrift::ServerSocket.new(9090)
transportFactory = Thrift::BufferedTransportFactory.new()
server = Thrift::SimpleServer.new(processor, transport, transportFactory)

puts "Starting the server..."
server.serve()
puts "done."