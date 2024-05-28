import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_tecnico_vision/controller/shopping_list_controller.dart';
import 'package:teste_tecnico_vision/models/lista.dart';
import 'package:teste_tecnico_vision/presentation/screens/insert_itens_screen.dart';
import 'package:teste_tecnico_vision/blocs/listaCompras/lista_compras_bloc.dart';
import 'package:teste_tecnico_vision/blocs/listaCompras/lista_compras_evento.dart';

class ItemSearchBar extends StatelessWidget {
  final ShoppingListController controller;
  final ListaCompras shoppingList;

  const ItemSearchBar({required this.controller, required this.shoppingList});

  void _navigateToProductCreationPage(BuildContext context) {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => ProductCreationPage(shoppingList: shoppingList),
      ),
    )
        .then((value) {
      BlocProvider.of<ShoppingListBloc>(context).add(CarregarListaCompra());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: TextField(
        controller: TextEditingController(),
        onSubmitted: (value) {
          controller.updateSearchTerm(value.isNotEmpty ? value : '');
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
          hintText: 'Nome do produto',
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 30,
              width: 30,
              decoration: const BoxDecoration(
                color: Colors.yellow,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () => _navigateToProductCreationPage(context),
                icon: const Icon(
                  Icons.add,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
