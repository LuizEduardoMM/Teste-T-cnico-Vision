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
            BlocProvider.of<ShoppingListBloc>(context).add(LimparListaCompra(shoppingList.nome)); // Resposta: Sim
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Lista ${shoppingList.nome} limpa com sucesso'),
                ));
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.red,
            ),
            padding:
            const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: const Text(
              'Limpar',
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
