from calculadora import Calculadora

from thrift import Thrift
from thrift.transport import TSocket
from thrift.transport import TTransport
from thrift.protocol import TBinaryProtocol

transport = TSocket.TSocket("localhost", 9090)
transport = TTransport.TBufferedTransport(transport)
protocol = TBinaryProtocol.TBinaryProtocol(transport)

client = Calculadora.Client(protocol)

transport.open()

print("hacemos ping al server")
client.ping()

resultado = client.suma(10, 4)
print("10 + 4 = " + str(resultado))
resultado = client.resta(10, 4)
print("10 - 4 = " + str(resultado))
resultado = client.multiplica(10, 4)
print("10 * 4 = " + str(resultado))
resultado = client.divide(10, 4)
print("10 / 4 = " + str(resultado))
resultado = client.sumaVectores([10, 15, -5], [4, 2, 1])
print("[10, 15, -5] + [4, 2, 1] = " + str(resultado))
resultado = client.restaVectores([10, 15, -5], [4, 2, 1])
print("[10, 15, -5] - [4, 2, 1] = " + str(resultado))
resultado = client.multiplicaVectores([10, 15, -5], [4, 2, 1])
print("[10, 15, -5] * [4, 2, 1] = " + str(resultado))
resultado = client.divideVectores([10, 15, -5], [4, 2, 1])
print("[10, 15, -5] / [4, 2, 1] = " + str(resultado))
resultado = client.reduceConSuma([10, 15, -5])
print("reduccion con suma([10, 15, -5]) = " + str(resultado))
c1 = Calculadora.Coordenada(5, 10)
c2 = Calculadora.Coordenada(20, 4)
resultado = client.distanciaManhattan(c1, c2)
print("DistanciaManhattan({5, 10}, {20, 4}) = " + str(resultado))
resultado = client.distanciaEuclides(c1, c2)
print("distanciaEuclides({5, 10}, {20, 4}) = " + str(resultado))

transport.close()
