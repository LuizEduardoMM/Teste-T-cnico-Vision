import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/itens.dart';

class ItemRepositorio {
  static const String _chaveItens = 'shopping_items';

  Future<List<Item>> carregarItens() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(_chaveItens);
    if (jsonString != null) {
      List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => Item.fromJson(json)).toList();
    }
    return [];
  }

  Future<void> adicionarItem(Item item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Item> itens = await carregarItens();
    itens.add(item);
    await prefs.setString(_chaveItens, json.encode(itens.map((item) => item.toJson()).toList()));
  }

  Future<void> excluirItem(Item item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Item> itens = await carregarItens();
    itens.removeWhere((element) => element.nome == item.nome);
    await prefs.setString(_chaveItens, json.encode(itens.map((item) => item.toJson()).toList()));
  }
}
