import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_tecnico_vision/blocs/listaCompras/lista_compras_bloc.dart';
import 'package:teste_tecnico_vision/models/lista.dart';
import 'package:teste_tecnico_vision/models/itens.dart';
import 'package:teste_tecnico_vision/blocs/listaCompras/lista_compras_evento.dart';

class ShoppingListDetailPage extends StatelessWidget {
  final ListaCompras shoppingList;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final List<String> categories = ['Alimentos', 'Limpeza', 'Higiene', 'Outros'];
  String selectedCategory = 'Alimentos';

  ShoppingListDetailPage({required this.shoppingList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(shoppingList.nome)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Nome do produto'),
                ),
                TextField(
                  controller: _quantityController,
                  decoration: const InputDecoration(labelText: 'Quantidade'),
                  keyboardType: TextInputType.number,
                ),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  items: categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    if (newValue != null) {
                      selectedCategory = newValue;
                    }
                  },
                  decoration: const InputDecoration(labelText: 'Categoria'),
                ),
                TextField(
                  controller: _priceController,
                  decoration: const InputDecoration(labelText: 'Preço (opcional)'),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_nameController.text.isNotEmpty && _quantityController.text.isNotEmpty) {
                      final newProduct = Item(
                        nome: _nameController.text,
                        quantidade: int.parse(_quantityController.text),
                        categoria: selectedCategory,
                        preco: _priceController.text.isNotEmpty ? double.parse(_priceController.text) : null,
                      );
                      context.read<ShoppingListBloc>().add(AddProdutoListaCompra(shoppingList.nome, newProduct));
                      _nameController.clear();
                      _quantityController.clear();
                      _priceController.clear();
                    }
                  },
                  child: const Text('Adicionar Produto'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: shoppingList.itens.length,
              itemBuilder: (context, index) {
                final product = shoppingList.itens[index];
                return ListTile(
                  title: Text(product.nome),
                  subtitle: Text('Quantidade: ${product.quantidade} - Categoria: ${product.categoria}'),
                  trailing: product.preco != null ? Text('R\$ ${product.preco}') : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
