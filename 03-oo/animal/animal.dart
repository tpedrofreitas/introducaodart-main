import 'alimento.dart';
import 'especie.dart';

class Animal {
  String nome;
  double peso;
  Alimento? alimento;
  Especie? especie;

  Animal(this.nome, this.peso, [this.alimento, this.especie]);
  void fazerSom() {
    print('$nome faz um som.');
  }

  void comer() {
    if (alimento != null) {
      print('$nome está comendo ${alimento!.tipo}.');
    } else {
      print('$nome está comendo.');
    }
  }
}
