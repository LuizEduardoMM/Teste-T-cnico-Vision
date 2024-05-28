import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_tecnico_vision/blocs/listaCompras/lista_compras_bloc.dart';
import 'package:teste_tecnico_vision/models/lista.dart';

import '../../blocs/listaCompras/lista_compras_evento.dart';

class DialogDeleteList extends StatelessWidget {
  final ListaCompras shoppingList;

  const DialogDeleteList({Key? key, required this.shoppingList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Tem certeza que deseja apagar ${shoppingList.nome}?',
        style: const TextStyle(
          fontFamily: 'Brutel',
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
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
              color: Colors.amber,
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
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
            context
                .read<ShoppingListBloc>()
                .add(DeleteListaCompra(shoppingList));
            Navigator.of(context).pop();
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.red,
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: const Text(
              'Apagar',
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
  }
}
