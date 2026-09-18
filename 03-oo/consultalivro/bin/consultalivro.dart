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
    var livros = await livroController.buscarLivro(buscaValidada);

    print("\n${livros.length} resultado(s) encontrado(s):\n");

    for (var i = 0; i < livros.length; i++) {
      var livro = livros[i];
      print("--- Livro ${i + 1} ---");
      print("Título: ${livro.titulo}");
      print("Autor(es): ${livro.autores.join(', ')}");
      print("Ano da primeira publicação: ${livro.anoPrimeiraPublicacao}");
      print("Quantidade de edições: ${livro.quantidadeEdicoes}");
      print("Idioma(s): ${livro.idiomas.join(', ')}");
      print("");
    }
  } on BuscaInvalidaException catch (e) {
    print("\nErro: $e");
  } catch (e) {
    print("\nErro inesperado: $e");
  }
}