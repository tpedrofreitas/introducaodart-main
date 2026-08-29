import 'enum.dart';
import 'forma.dart';

class Retangulo extends Forma {
  double base;
  double altura;

  Retangulo(this.base, this.altura) : super(tpForma.Retangulo);

  @override
  double calculaArea() {
    return this.base * this.altura;
  }
}
