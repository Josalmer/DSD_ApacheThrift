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

  def reduceConSuma(v1)
    result = v1.reduce(:+)
    print "reduccion con suma(#{v1.inspect}) = #{result}\n"
    return result
  end

  def distanciaManhattan(c1, c2)
    result = (c1.x - c2.x).abs + (c1.y - c2.y).abs
    print "DistanciaManhattan(#{c1.inspect}, #{c2.inspect}) = #{result}\n"
    return result
  end

  def distanciaEuclides(c1, c2)
    deltaX = c1.x - c2.x
    deltaY = c1.y - c2.y
    result = Math.sqrt(deltaX*deltaX + deltaY*deltaY)
    print "distanciaEuclides(#{c1.inspect}, #{c2.inspect}) = #{result}\n"
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