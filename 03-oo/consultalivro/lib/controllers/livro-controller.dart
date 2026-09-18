import 'package:consultalivro/exceptions/busca-invalida-exception.dart';
import 'package:consultalivro/models/livro.dart';
import 'package:consultalivro/services/livro-service.dart';

class LivroController {
  LivroService livroService = LivroService();

  String validaBusca(String? busca) {
    if (busca == null || busca.trim().isEmpty) {
      throw BuscaInvalidaException();
    } else {
      return busca.trim().replaceAll(' ', '+');
    }
  }

  Future<List<Livro>> buscarLivro(String busca) async {
    return livroService.consultar(busca);
  }
}
