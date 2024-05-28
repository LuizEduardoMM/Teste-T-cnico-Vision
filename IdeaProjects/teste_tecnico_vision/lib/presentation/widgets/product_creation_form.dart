import 'package:flutter/material.dart';
import 'package:teste_tecnico_vision/models/itens.dart';

class ProductCreationForm extends StatefulWidget {
  final Function(Item) onSubmit;

  const ProductCreationForm({required this.onSubmit});

  @override
  _ProductCreationFormState createState() => _ProductCreationFormState();
}

class _ProductCreationFormState extends State<ProductCreationForm> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();
  String? _selectedCategory;

  @override
  void dispose() {
    _productNameController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _addProduct() {
    if (_formKey.currentState!.validate()) {
      final newProduct = Item(
        nome: _productNameController.text,
        quantidade: int.parse(_quantityController.text),
        preco: _priceController.text.isNotEmpty
            ? double.parse(_priceController.text)
            : null,
        categoria: _selectedCategory ?? 'Sem categoria',
      );

      widget.onSubmit(newProduct);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Categoria',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            items:
                ['Alimentos', 'Limpeza', 'Higiene', 'Outros'].map((category) {
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
    );
  }
}
