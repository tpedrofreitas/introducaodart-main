import 'dart:io';
import 'package:consultalivro/controllers/livro-controller.dart';
import 'package:consultalivro/exceptions/busca-invalida-exception.dart';
 
void main() async {
  LivroController livroController = LivroController();

  print("=== Consulta de Livros - Open Library ===");
  stdout.write("Digite o título do livro que deseja pesquisar: ");
  String? entrada = stdin.readLineSync();

  try {
    String buscaValidada = livroController.validaBusca(entrada);
    var livro = await livroController.buscarLivro(buscaValidada);

    print("\nResultado encontrado:");
    print("Título: ${livro.titulo}");
    print("Autor(es): ${livro.autores.join(', ')}");
    print("Ano da primeira publicação: ${livro.anoPrimeiraPublicacao}");
    print("Quantidade de edições: ${livro.quantidadeEdicoes}");
    print("Idioma(s): ${livro.idiomas.join(', ')}");
  } on BuscaInvalidaException catch (e) {
    print("\nErro: $e");
  } catch (e) {
    print("\nErro inesperado: $e");
  }
}
