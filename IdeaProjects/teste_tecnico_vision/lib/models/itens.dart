import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> saveToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('${nome}_isSelected', isSelected.value);
  }

  Future<void> removeFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('${nome}_isSelected');
  }
}
