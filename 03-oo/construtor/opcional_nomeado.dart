class Carro {
  String fabricante;
  String modelo;
  int anoFabricacao;
  int anoModelo;
  bool temABS;

  //Construtor com parametros
  Carro({
    required this.fabricante,
    required this.modelo,
    this.anoFabricacao = 2012,
    this.anoModelo = 2011,
    this.temABS = true,
  });

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

  @override
  String toString() {
    return retornaDados();
  }
}
