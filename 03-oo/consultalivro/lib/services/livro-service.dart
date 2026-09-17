import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:consultalivro/models/livro.dart';

class LivroService {
  final String _baseUrl = "https://openlibrary.org/search.json?q=";

  Future<Livro> consultar(String busca) async {
    final url = Uri.parse("$_baseUrl$busca");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final dados = json.decode(response.body);
      final docs = dados['docs'] as List;

      if (docs.isEmpty) {
        throw Exception("Nenhum livro encontrado para essa busca.");
      }

      return Livro.fromJson(docs[0]);
    } else {
      throw Exception(
          "Erro ao consultar a API. Código: ${response.statusCode}");
    }
  }
}
