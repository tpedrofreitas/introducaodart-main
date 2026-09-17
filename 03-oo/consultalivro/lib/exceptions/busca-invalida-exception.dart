class BuscaInvalidaException implements Exception {
  final String mensagem;

  BuscaInvalidaException(
      [this.mensagem = "Busca inválida!!! Digite um título para pesquisar."]);

  @override
  String toString() => mensagem;
}