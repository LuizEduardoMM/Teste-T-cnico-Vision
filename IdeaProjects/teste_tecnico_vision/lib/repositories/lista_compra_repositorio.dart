import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste_tecnico_vision/models/lista.dart';

class ListaCompraRepositorio {
  static const String _chaveListaCompras = 'shopping_lists';

  Future<List<ListaCompras>> carregarListaShopping() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(_chaveListaCompras);
    if (jsonString != null) {
      List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => ListaCompras.fromJson(json)).toList();
    }
    return [];
  }

  Future<void> salvarListaCompras(List<ListaCompras> shoppingLists) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(_chaveListaCompras,
        json.encode(shoppingLists.map((lista) => lista.toJson()).toList()));
  }

  Future<void> excluirListaCompras(ListaCompras lista) async {
    List<ListaCompras> listaCompras = await carregarListaShopping();
    listaCompras.removeWhere((element) => element.nome == lista.nome);
    await salvarListaCompras(listaCompras);
  }
}
