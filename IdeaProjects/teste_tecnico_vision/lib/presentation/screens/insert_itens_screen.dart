import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_tecnico_vision/models/lista.dart';
import 'package:teste_tecnico_vision/models/itens.dart';
import 'package:teste_tecnico_vision/presentation/widgets/custom_app_bar_cart.dart';
import 'package:teste_tecnico_vision/presentation/widgets/product_creation_form.dart';
import 'package:teste_tecnico_vision/blocs/listaCompras/lista_compras_bloc.dart';
import 'package:teste_tecnico_vision/blocs/listaCompras/lista_compras_evento.dart';

class ProductCreationPage extends StatefulWidget {
  final ListaCompras shoppingList;

  ProductCreationPage({required this.shoppingList});

  @override
  _ProductCreationPageState createState() => _ProductCreationPageState();
}

class _ProductCreationPageState extends State<ProductCreationPage> {
  final Completer<void> _stateCompleter = Completer<void>();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ShoppingListBloc>(context).stream.listen((state) {
      if (!_stateCompleter.isCompleted) {
        _stateCompleter.complete();
      }
    });
  }

  void _addProduct(Item newProduct) {
    BlocProvider.of<ShoppingListBloc>(context)
        .add(AddProdutoListaCompra(widget.shoppingList.nome, newProduct));
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.amber,
      appBar: CustomAppBarCart(),
      body: Column(
        children: [
          AppBar(
            title: const Text(
              'Adicionar Produto',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Brutel',
              ),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ProductCreationForm(onSubmit: _addProduct),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
