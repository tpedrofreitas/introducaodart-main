class Carro {
  String? fabricante;
  String? modelo;
  int? anoFabricacao;
  int? anoModelo;
  bool? temABS;

  void imprimeDados() {
    print(retornaDados());
  }

  String retornaDados() {
    return '''
            Fabricante: ${this.fabricante} \n
            modelo: ${this.modelo} \n
            Ano Fabricação:${this.anoFabricacao} \n
            Ano do Modelo: ${this.anoModelo} \n
            Tem ABS: ${(this.temABS!) ? "Sim" : "Não"}\n
          ''';
  }
}
