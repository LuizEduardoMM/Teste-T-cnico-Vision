class Item {
  final String nome;
  final int quantidade;
  final String categoria;
  final double? preco;

  Item({
    required this.nome,
    required this.quantidade,
    required this.categoria,
    this.preco,
  });

  Map<String, dynamic> toJson() => {
    'nome': nome,
    'quantidade': quantidade,
    'categoria': categoria,
    'preco': preco,
  };

  static Item fromJson(Map<String, dynamic> json) => Item(
    nome: json['name'],
    quantidade: json['quantidade'],
    categoria: json['categoria'],
    preco: json['preco']?.toDouble(),
  );
}
