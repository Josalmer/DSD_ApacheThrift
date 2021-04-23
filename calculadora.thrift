struct Coordenada {
   1: required double x;
   2: required double y;
}

service Calculadora{
   void ping(),
   double suma(1:double num1, 2:double num2),
   double resta(1:double num1, 2:double num2),
   double multiplica(1:double num1, 2:double num2),
   double divide(1:double num1, 2:double num2),
	double distanciaManhattan(1: Coordenada c1, 2: Coordenada c2),
	double distanciaEuclides(1: Coordenada c1, 2: Coordenada c2),
   list<double> sumaVectores(1:list<double> v1, 2:list<double> v2),
   list<double> restaVectores(1:list<double> v1, 2:list<double> v2),
   list<double> multiplicaVectores(1:list<double> v1, 2:list<double> v2),
   list<double> divideVectores(1:list<double> v1, 2:list<double> v2),
   double reduce(1:list<double> v1);
}

/*
   thrift -r --gen rb calculadora.thrift <-- Genera archivos necesarios para scripts con Ruby
   thrift -r --gen py calculadora.thrift <-- Genera archivos necesarios para scripts con Python
*/