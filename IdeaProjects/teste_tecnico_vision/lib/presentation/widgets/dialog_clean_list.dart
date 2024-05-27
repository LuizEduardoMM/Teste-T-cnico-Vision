import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_tecnico_vision/blocs/listaCompras/lista_compras_bloc.dart';
import 'package:teste_tecnico_vision/models/lista.dart';

import '../../blocs/listaCompras/lista_compras_evento.dart';

class DialogCleanList extends StatelessWidget {
  final ListaCompras shoppingList;

  const DialogCleanList({required this.shoppingList});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Limpar Lista de Compras',
        style: TextStyle(
          fontFamily: 'Brutel',
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tem certeza que deseja limpar todos os itens da lista ${shoppingList.nome}?',
            style: const TextStyle(fontFamily: 'Brutel'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Não',
            style: TextStyle(
              fontFamily: 'Brutel',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            BlocProvider.of<ShoppingListBloc>(context).add(LimparListaCompra(shoppingList.nome)); // Resposta: Sim
            Navigator.of(context).pop();
          },
          child: const Text(
            'Sim',
            style: TextStyle(
              fontFamily: 'Brutel',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
