import 'animal.dart';
import 'alimento.dart';
import 'especie.dart';

class Gato extends Animal {
  int ronrom;

  Gato(String nome, double peso, this.ronrom, Alimento alimento)
    : super.completo(nome, peso, alimento, Especie.MAMIFEROS);

  void fazerCarinho() {
    print('$nome está ronronando de tanto carinho.');
  }

  @override
  void fazerSom() {
    print('$nome (Gato) faz: Miau!');
  }

  @override
  String toString() {
    return 'Gato{nome: $nome, peso: $peso, ronrom: $ronrom, especie: $especie}';
  }
}
