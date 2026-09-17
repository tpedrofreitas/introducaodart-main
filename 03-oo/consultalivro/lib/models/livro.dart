class Livro {
  String titulo;
  List<String> autores;
  int anoPrimeiraPublicacao;
  int quantidadeEdicoes;
  List<String> idiomas;

  Livro({
    required this.titulo,
    required this.autores,
    required this.anoPrimeiraPublicacao,
    required this.quantidadeEdicoes,
    required this.idiomas,
  });

  //cria um Livro a partir do JSON retornado pela API
  factory Livro.fromJson(Map<String, dynamic> json) {
    return Livro(
      titulo: json['title'] ?? 'Título não informado',
      autores: json['author_name'] != null
          ? List<String>.from(json['author_name'])
          : ['Autor não informado'],
      anoPrimeiraPublicacao: json['first_publish_year'] ?? 0,
      quantidadeEdicoes: json['edition_count'] ?? 0,
      idiomas: json['language'] != null
          ? List<String>.from(json['language'])
          : ['Idioma não informado'],
    );
  }
}