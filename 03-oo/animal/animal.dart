import 'alimento.dart';
import 'especie.dart';

abstract class Animal {
  String nome;
  double peso;
  Alimento? alimento;
  Especie? especie;

  Animal.completo(this.nome, this.peso, this.alimento, this.especie);

  factory Animal(String nome, double peso) = _AnimalGenerico;

  void fazerSom();

  void comer() {
    if (alimento != null) {
      print('$nome está comendo ${alimento!.tipo}.');
    } else {
      print('$nome está comendo.');
    }
  }
}

class _AnimalGenerico extends Animal {
  _AnimalGenerico(String nome, double peso)
    : super.completo(nome, peso, null, null);

  @override
  void fazerSom() {
    print('$nome faz um som.');
  }
}
