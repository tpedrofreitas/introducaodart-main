class Carro {
  String fabricante;
  String modelo;
  int anoFabricacao;
  int anoModelo;
  bool temABS;

  Carro({
    required this.fabricante,
    required this.modelo,
    required this.anoFabricacao,
    required this.anoModelo,
    required this.temABS,
  });
  //Construtor com parametros
  void imprimeDados() {
    print(retornaDados());
  }

  String retornaDados() {
    return '''
            Fabricante: ${this.fabricante} \n
            modelo: ${this.modelo} \n
            Ano Fabricação:${this.anoFabricacao} \n
            Ano do Modelo: ${this.anoModelo} \n
            Tem ABS: ${(this.temABS) ? "Sim" : "Não"}\n
          ''';
  }
}
