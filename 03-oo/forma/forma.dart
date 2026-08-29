import 'enum.dart';

abstract class Forma {
  //declarando uma variavel de instancia
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
    print("${tipoForma.name} -${tipoForma.index} com area de ${calculaArea()}");
  }
}
