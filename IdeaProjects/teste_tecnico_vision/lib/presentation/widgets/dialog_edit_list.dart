import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_tecnico_vision/blocs/listaCompras/lista_compras_bloc.dart';
import 'package:teste_tecnico_vision/blocs/listaCompras/lista_compras_evento.dart';
import 'package:teste_tecnico_vision/models/lista.dart';

class DialogEditList {
  static void show(BuildContext context, ListaCompras shoppingList) {
    TextEditingController _dialogController =
        TextEditingController(text: shoppingList.nome);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Editar lista de compras',
            style: TextStyle(
              fontFamily: 'Brutel',
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          content: TextField(
            controller: _dialogController,
            decoration: InputDecoration(
              hintText: 'Nome da lista',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.red,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: const Text(
                  'Cancelar',
                  style: TextStyle(
                    fontFamily: 'Brutel',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                final novoNome = _dialogController.text;
                BlocProvider.of<ShoppingListBloc>(context)
                    .add(EditarNomeListaCompra(shoppingList.nome, novoNome));
                Navigator.of(context).pop();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.amber,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: const Text(
                  'Editar',
                  style: TextStyle(
                    fontFamily: 'Brutel',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
