import 'package:teste_tecnico_vision/models/itens.dart';

class ListaCompras {
  final String nome;
  final DateTime dataCriacao;
  final List<Item> itens;

  ListaCompras({
    required this.nome,
    required this.dataCriacao,
    required this.itens,
  });

  Map<String, dynamic> toJson() => {
    'nome': nome,
    'dataCriacao': dataCriacao.toIso8601String(),
    'produtos': itens.map((product) => product.toJson()).toList(),
  };

  static ListaCompras fromJson(Map<String, dynamic> json) => ListaCompras(
    nome: json['nome'],
    dataCriacao: DateTime.parse(json['dataCriacao']),
    itens: (json['produtos'] as List)
        .map((productJson) => Item.fromJson(productJson))
        .toList(),
  );
}
