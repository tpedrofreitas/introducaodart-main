import 'enum.dart';
import 'forma.dart';
import 'dart:math';

class Circulo extends Forma {
  double raio;

  Circulo(this.raio) : super(tpForma.Circulo);

  @override
  double calculaArea() {
    return pi * raio * raio;
  }
}
