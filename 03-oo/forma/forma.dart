import 'enum.dart';

abstract class Forma {
  tpForma tipoForma;

  //declarando o construção
  //Forma(tpForma VarForma){
  // this.tipoForma= varForma}

  Forma(this.tipoForma);

  //declarando um método abstratc
  //método abstrato não tem corpo
  double calculaArea();

  //declarando um método de instancia (concreto)
  void imprimeForma() {
    print("${tipoForma.name} com area de ${calculaArea()}");
  }
}
