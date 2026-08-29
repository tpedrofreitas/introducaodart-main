import 'circulo.dart';
import 'forma.dart';
import 'quadrado.dart';
import 'retangulo.dart';
import 'triangulo.dart';

void main(List<String> args) {
  //polimorfismo
  Forma objQuadrado = Quadrado(15.0);
  objQuadrado.imprimeForma();

  Forma objRetangulo = Retangulo(10.5, 20.6);
  objRetangulo.imprimeForma();

  Forma objTriangulo = Triangulo(8.0, 4.4);
  objTriangulo.imprimeForma();

  Forma objCirculo = Circulo(7.0);
  objCirculo.imprimeForma();

  List<Forma> formas = [];
  formas.add(Quadrado(8.0));
  formas.add(Retangulo(10.5, 5.0));
  formas.add(Triangulo(12.5, 4.5));
  formas.add(Circulo(15.0));

  print("\n---->Coleção<----");
  formas.forEach((Forma) => Forma.imprimeForma());
}
