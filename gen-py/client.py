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

def basica():
    print("Introduzca operación (operandoA operador operandoB, separados por espacios)(operandos disponibles: + - x /): ")
    x, op, y = input().split()
    x, y = float(x), float(y)
    if op == '+':
        resultado = client.suma(x, y)
        print("{} + {} = {}".format(x, y, resultado))
    elif op == '-':
        resultado = client.resta(x, y)
        print("{} - {} = {}".format(x, y, resultado))
    elif op == 'x':
        resultado = client.multiplica(x, y)
        print("{} * {} = {}".format(x, y, resultado))
    elif op == '/':
        resultado = client.divide(x, y)
        print("{} / {} = {}".format(x, y, resultado))
    else:
        print("Operación incorrecta, recuerde operandos separados por espacios")

def distancia():
    print("Introduzca coordenadas de los puntos y elija tipo de distancia (m (manhattan), e (euclides)) \ncoordenadaAX coordenadaAY coordenadaBX coordenadaBY operacion, separados por espacios: ")
    x1, y1, x2, y2, op = input().split()
    x1, y1, x2, y2 = float(x1), float(y1), float(x2), float(y2)
    c1 = Calculadora.Coordenada(x1, y1)
    c2 = Calculadora.Coordenada(x2, y2)
    if op == 'm':
        resultado = client.distanciaManhattan(c1, c2)
        print("DistanciaManhattan(({}, {}), ({}, {})) = {}".format(x1, y1, x2, y2, resultado))
    elif op == 'e':
        resultado = client.distanciaEuclides(c1, c2)
        print("distanciaEuclides(({}, {}), ({}, {})) = {}".format(x1, y1, x2, y2, resultado))
    else:
        print("Operación incorrecta, recuerde operandos separados por espacios")

def vectores():
    print("Introduzca operación:\n\tr reducción con suma de un vector\n\t+ suma dos vectores\n\t- resta dos vectores\n\tx multiplica dos vectores\n\t/ divide dos vectores\n")
    op = input()
    print("Introduzca vector A[] (componentes separadas por espacios)")
    v1 = input().split()
    v1 = [float(i) for i in v1]
    if op != 'r':
        print("Introduzca vector B[] (componentes separadas por espacios)")
        v2 = input().split()
        v2 = [float(i) for i in v2]
        if len(v1) != len(v2):
            print("Longitud de los vectores no coincide")
            return
    if op == '+':
        resultado = client.sumaVectores(v1, v2)
        print("{} + {} = {}".format(str(v1), str(v2), str(resultado)))
    if op == '-':
        resultado = client.restaVectores(v1, v2)
        print("{} - {} = {}".format(str(v1), str(v2), str(resultado)))
    if op == 'x':
        resultado = client.multiplicaVectores(v1, v2)
        print("{} * {} = {}".format(str(v1), str(v2), str(resultado)))
    if op == '/':
        resultado = client.divideVectores(v1, v2)
        print("{} / {} = {}".format(str(v1), str(v2), str(resultado)))
    if op == 'r':
        resultado = client.reduceConSuma(v1)
        print("reduccion con suma({}) = {}".format(str(v1), str(resultado)))

tipo = 0
while tipo != 'x':

    print("Elija tipo de operación:\n\tb (Básica + - x /)\n\td (cálculo de Distancia manhattan o euclidea)\n\tv operaciones con Vectores\n\tx eXit\n")
    tipo = input()

    if tipo == 'b':
        basica()

    elif tipo == 'd':
        distancia()

    elif tipo == 'v':
        vectores()

    else:
        print("Introduzca un tipo de operación valido (x para salir)")

transport.close()
