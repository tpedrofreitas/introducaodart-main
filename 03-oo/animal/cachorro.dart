import 'animal.dart';
import 'alimento.dart';
import 'especie.dart';
import 'brinquedo.dart';

class Cachorro extends Animal {
  int fofura;

  List<Brinquedo> brinquedos;

  Cachorro(String nome, double peso, this.fofura, Alimento alimento)
    : brinquedos = [],

      super.completo(nome, peso, alimento, Especie.MAMIFEROS);

  void incluirBrinquedo(Brinquedo brinquedo) {
    brinquedos.add(brinquedo);
    print('$nome ganhou um novo brinquedo com ${brinquedo.nome}.');
  }

  void brincar(Brinquedo brinquedo) {
    print('$nome está brincando com ${brinquedo.nome}.');
  }

  @override
  void fazerSom() {
    print('$nome (Cachorro) faz: Au au!');
  }

  @override
  String toString() {
    return 'Cachorro{nome: $nome, peso: $peso, fofura: $fofura, especie: $especie, brinquedos: ${brinquedos.length}}';
  }
}
