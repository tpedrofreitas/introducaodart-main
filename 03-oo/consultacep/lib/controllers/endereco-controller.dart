import 'dart:convert';

import 'package:consultacep/models/endereco.dart';
import 'package:http/http.dart' as http;

class EnderecoController {
  Future<Endereco> buscarEndereco(String cep) async {
    final url = Uri.parse('http://viacep.com.br/ws/$cep/json/');
  final resposta;
    try{
      resposta = await http.get(url);
    }catch(e){
      throw Exception("Erro na url: ${e.toString()}");
    }
    

    if (resposta.statusCode == 200 ){

      Map<String, dynamic> cep = jsonDecode(resposta.body);
      
      if (cep.containsKey('erro') && cep['erro'] == 'true'){
        throw Exception("CEP não encontrado!!");
      } else {
        return Endereco.deJson(cep);
      }
    } else{
      throw Exception("Erro na busca do endereço:${resposta.statusCode}");
    }
  }
}
