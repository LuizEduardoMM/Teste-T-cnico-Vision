import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/listaCompras/lista_compras_bloc.dart';
import '../../blocs/listaCompras/lista_compras_evento.dart';
import '../../models/lista.dart';

class DialogCreateList {
  static void show(BuildContext context) {
    TextEditingController _dialogController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Criar nova lista de compras',
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
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
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
                if (_dialogController.text.isNotEmpty) {
                  final newList = ListaCompras(
                    nome: _dialogController.text,
                    dataCriacao: DateTime.now(),
                    itens: [],
                  );
                  context.read<ShoppingListBloc>().add(AddListaCompra(newList));
                  Navigator.of(context).pop();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color:Colors.amber,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: const Text(
                  'Criar',
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

