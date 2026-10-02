import 'dart:convert';

import 'package:http/http.dart' as http;

import '../exceptions/localizacao-nao-encontrada-exception.dart';
import '../models/localizacao.dart';

class LocalizacaoService {
  Future<Localizacao> consultar(String cep) async {
    final url = Uri.parse('https://cep.awesomeapi.com.br/json/$cep');

    final resposta = await http.get(url);

    if (resposta.statusCode == 200) {
      final Map<String, dynamic> dados = jsonDecode(resposta.body);
      return Localizacao.deJson(dados);
    }

    throw LocalizacaoNaoEncontradaException();
  }
}
