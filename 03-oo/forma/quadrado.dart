import 'forma.dart';
import 'enum.dart';

//Herança/Generalização
//Classe quadrado herda os membros (variaveis de instancia e metodos de Forma)

class Quadrado extends Forma {
  double lado;

  //construtor da classe quadrado
  //chamando o construtor da classe pai
  Quadrado(this.lado) : super(tpForma.Quadrado);

  //sobrescrever o método abstrato da classe pai
  @override
  double calculaArea() {
    return lado * lado;
  }
}
