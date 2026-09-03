import 'alimento.dart';
import 'brinquedo.dart';
import 'animal.dart';
import 'cachorro.dart';
import 'gato.dart';
import 'tratamento.dart';
import 'veterinario.dart';

void main(List<String> args) {
  Alimento racaoCachorro = Alimento('Ração Carne');
  Alimento racaoGato = Alimento('Ração Peixe');

  Cachorro rex = Cachorro('Rex', 18.5, 9, racaoCachorro);
  Gato mimi = Gato('Mimi', 4.2, 10, racaoGato);

  Brinquedo bola = Brinquedo('Bolinha de borracha');
  Brinquedo osso = Brinquedo('Osso de brinquedo');

  rex.incluirBrinquedo(bola);
  rex.incluirBrinquedo(osso);

  print('');

  print('--- Cachorro ---');
  rex.comer();
  rex.brincar(bola);
  rex.fazerSom();
  print(rex);

  print('');

  print('--- Gato ---');
  mimi.comer();
  mimi.fazerCarinho();
  mimi.fazerSom();
  print(mimi);

  print('');

  print('--- Polimorfismo ---');
  Animal a1 = rex;
  Animal a2 = mimi;

  a1.fazerSom();
  a2.fazerSom();

  print('');
  print('--- Veterinário ---');
  Animal animal = Animal('Thor', 5);
  Veterinario vet = Veterinario('Dra. Mariana');
  Tratamento tratamento = Tratamento('Aplicação de vacina');

  vet.atender(animal);
  vet.atender(animal, tratamento);
}
