import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_tecnico_vision/blocs/listaCompras/lista_compras_bloc.dart';
import 'package:teste_tecnico_vision/blocs/listaCompras/lista_compras_evento.dart';
import 'package:teste_tecnico_vision/models/itens.dart';

void showEditItemDialog(BuildContext context, Item item) {
  final TextEditingController _nomeController =
      TextEditingController(text: item.nome);
  final TextEditingController _quantidadeController =
      TextEditingController(text: item.quantidade.toString());
  final TextEditingController _precoController =
      TextEditingController(text: item.preco?.toString() ?? '');

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text(
          'Editar item',
          style: TextStyle(fontFamily: 'Brutel', fontWeight: FontWeight.w300),
        ),
        content: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _nomeController,
                    decoration: InputDecoration(
                        hintText: "Nome do item",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _quantidadeController,
                    decoration: InputDecoration(
                        hintText: "Quantidade",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _precoController,
                    decoration: InputDecoration(
                        hintText: "Preço",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
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
              final nome = _nomeController.text;
              final quantidade = int.parse(_quantidadeController.text);
              final preco = _precoController.text.isNotEmpty
                  ? double.parse(_precoController.text)
                  : null;

              final itemAtualizado = Item(
                  nome: nome,
                  quantidade: quantidade,
                  preco: preco,
                  categoria: item.categoria);

              BlocProvider.of<ShoppingListBloc>(context)
                  .add(EditarItemListaCompra(item.nome, itemAtualizado));

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
                'Salvar',
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
