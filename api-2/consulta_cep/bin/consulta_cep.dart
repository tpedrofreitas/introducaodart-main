import 'dart:convert';
//dart pub add http (importa o pacote do pub.dev)
//declara o http para utilização na classe/função
import 'package:http/http.dart' as http;

Future<void> main(List<String> arguments) async {
  //Future: resultado que ainda vai chegar
  //async: permite usa await dentro da função/método
  //await: espera o resultado

  final url = Uri.parse("https://viacep.com.br/ws/17509060/json");
  // final url = Uri.parse("https://viacep.com.br/ws/17509000/json");

  final resposta = await http.get(url);

  if (resposta.statusCode == 200) {
    Map<String, dynamic> cep = jsonDecode(resposta.body);

    print("Logradouro: ${cep['logradouro']}");
    print("Bairro: ${cep['bairro']}");
    print("Localidade: ${cep['localidade']}");
    print("UF: ${cep['uf']}");
  } else {
    print("CEP inválido  ou inexistente!");
  }
}
