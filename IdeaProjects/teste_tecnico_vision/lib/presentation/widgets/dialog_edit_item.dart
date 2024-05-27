import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/listaCompras/lista_compras_bloc.dart';
import '../../blocs/listaCompras/lista_compras_evento.dart';
import '../../models/itens.dart';
void showEditItemDialog(BuildContext context, Item item) {
  final TextEditingController _nomeController = TextEditingController(text: item.nome);
  final TextEditingController _quantidadeController = TextEditingController(text: item.quantidade.toString());
  final TextEditingController _precoController = TextEditingController(text: item.preco?.toString() ?? '');

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Editar Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(hintText: "Nome do Item"),
            ),
            TextField(
              controller: _quantidadeController,
              decoration: InputDecoration(hintText: "Quantidade"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _precoController,
              decoration: InputDecoration(hintText: "Preço"),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              final nome = _nomeController.text;
              final quantidade = int.parse(_quantidadeController.text);
              final preco = _precoController.text.isNotEmpty ? double.parse(_precoController.text) : null;

              final itemAtualizado = Item(nome: nome, quantidade: quantidade, preco: preco, categoria: item.categoria);

              BlocProvider.of<ShoppingListBloc>(context).add(EditarItemListaCompra(item.nome, itemAtualizado));

              Navigator.of(context).pop();
            },
            child: Text('Salvar'),
          ),
        ],
      );
    },
  );
}