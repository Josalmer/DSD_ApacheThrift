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

  def multiplica(n1, n2)
    result = n1 * n2
    print "#{n1} * #{n2} = #{result}\n"

    return result
  end

  def divide(n1, n2)
    if n2!=0
      result = n1 / n2
      print "#{n1} / #{n2} = #{result}\n"
      return result
    end
  end

  def sumaVectores(v1, v2)
    result = [v1, v2].transpose.map {|x| x.reduce(:+)}
    print "#{v1.inspect} + #{v2.inspect} = #{result.inspect}\n"
    return result
  end

  def restaVectores(v1, v2)
    result = [v1, v2].transpose.map {|x| x.reduce(:-)}
    print "#{v1.inspect} - #{v2.inspect} = #{result.inspect}\n"
    return result
  end

  def multiplicaVectores(v1, v2)
    result = [v1, v2].transpose.map {|x| x.reduce(:*)}
    print "#{v1.inspect} * #{v2.inspect} = #{result.inspect}\n"
    return result
  end

  def divideVectores(v1, v2)
    result = [v1, v2].transpose.map {|x| x.reduce(:/)}
    print "#{v1.inspect} / #{v2.inspect} = #{result.inspect}\n"
    return result
  end

  def reduce(v1)
    result = v1.map {|x| x.reduce(:+)}
    print "reduccion con suma(#{v1.inspect}) = #{result}\n"
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