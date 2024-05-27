import 'package:get/get.dart';

class Item {
  final String nome;
  final int quantidade;
  final String categoria;
  final double? preco;
  RxBool isSelected;

  Item({
    required this.nome,
    required this.quantidade,
    required this.categoria,
    this.preco,
    bool isSelected = false,
  }) : isSelected = RxBool(isSelected);

  Map<String, dynamic> toJson() => {
    'nome': nome,
    'quantidade': quantidade,
    'categoria': categoria,
    'preco': preco,
    'isSelected': isSelected.value,
  };

  static Item fromJson(Map<String, dynamic> json) => Item(
    nome: json['nome'],
    quantidade: json['quantidade'],
    categoria: json['categoria'],
    preco: json['preco']?.toDouble(),
    isSelected: json['isSelected'] ?? false,
  );
}
