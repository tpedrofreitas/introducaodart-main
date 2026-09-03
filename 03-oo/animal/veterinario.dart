import 'animal.dart';
import 'tratamento.dart';

class Veterinario {
  String nome;

  Veterinario(this.nome);

  void atender(Animal animal, [Tratamento? tratamento]) {
    if (tratamento == null) {
      print('$nome está atendendo o animal ${animal.nome}');
    } else {
      print(
        '$nome está tratando o animal ${animal.nome} com ${tratamento.descricao}',
      );
    }
  }
}
