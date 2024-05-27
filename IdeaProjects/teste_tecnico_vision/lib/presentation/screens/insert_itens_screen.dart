import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_tecnico_vision/models/lista.dart';
import 'package:teste_tecnico_vision/models/itens.dart';
import 'package:teste_tecnico_vision/presentation/widgets/custom_app_bar_cart.dart';
import 'package:teste_tecnico_vision/blocs/listaCompras/lista_compras_bloc.dart';


import '../../blocs/listaCompras/lista_compras_evento.dart';

class ProductCreationPage extends StatefulWidget {
  final ListaCompras shoppingList;

  ProductCreationPage({required this.shoppingList});

  @override
  _ProductCreationPageState createState() => _ProductCreationPageState();
}

class _ProductCreationPageState extends State<ProductCreationPage> {
  final _formKey = GlobalKey<FormState>();


  final _productNameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();
  String? _selectedCategory;

  Completer<void> _stateCompleter = Completer<void>();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ShoppingListBloc>(context).stream.listen((state) {
      if (!_stateCompleter.isCompleted) {
        _stateCompleter.complete();
      }
    });
  }

  void _addProduct() {
    if (_formKey.currentState!.validate()) {
      final newProduct = Item(
        nome: _productNameController.text,
        quantidade: int.parse(_quantityController.text),
        preco: double.parse(_priceController.text),
        categoria: _selectedCategory ?? 'Sem categoria',
      );

      BlocProvider.of<ShoppingListBloc>(context).add(AddProdutoListaCompra(widget.shoppingList.nome, newProduct));

      Navigator.pop(context,true);
    }
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
              'Adicionar Produto ',
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _productNameController,
                        decoration: InputDecoration(
                          labelText: 'Nome do Produto',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira o nome do produto';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _quantityController,
                        decoration: InputDecoration(
                          labelText: 'Quantidade',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira a quantidade';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _priceController,
                        decoration: InputDecoration(
                          labelText: 'Preço',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return null;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Categoria',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        items: ['Alimentos', 'Limpeza', 'Higiene', 'Outros']
                            .map((category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return "Escolha categoria";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.amber,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: _addProduct,
                        child: const Text(
                          'Adicionar',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Brutel',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
