import 'dart:convert';

import 'package:consultacep/exceptions/api-invalida-exception.dart';
import 'package:consultacep/exceptions/cep-invalido-exception.dart';
import 'package:consultacep/exceptions/cep-nao-encontrado.dart';
import 'package:consultacep/models/endereco.dart';
import 'package:http/http.dart' as http;

class EnderecoController {

  String validaCEP(String? cep) {
  if (cep == null || cep.isEmpty) {
   //throw Exception("CEP invalido!! Tente Novamente.");
  throw CepInvalidoException();
  } else {
    cep = cep.replaceAll(RegExp(r'[^0-9]'), '');

    if (cep.length != 8) {
      throw CepInvalidoException();
    } else {
      return cep;
    }
  }
}
  Future<Endereco> buscarEndereco(String cep) async {
    final url = Uri.parse('http://viacep.com.br/ws/$cep/json/');
  final resposta;
    try{
      resposta = await http.get(url);
    }catch(e){
      //throw Exception("Erro na url: ${e.toString()}");
      throw ApiInvalidaException("Erro na url: $e");
    }
    

    if (resposta.statusCode == 200 ){

      Map<String, dynamic> cep = jsonDecode(resposta.body);
      
      if (cep.containsKey('erro') && cep['erro'] == 'true'){
       // throw Exception("CEP não encontrado!!");
        throw CepNaoEncontradoException();
      } else {
        return Endereco.deJson(cep);
      }
    } else{
     //throw Exception("Erro na busca do endereço:${resposta.statusCode}");
     throw ApiInvalidaException("Erro ma busca do endereco: ${resposta.statusCode}");
    }
  }
}
