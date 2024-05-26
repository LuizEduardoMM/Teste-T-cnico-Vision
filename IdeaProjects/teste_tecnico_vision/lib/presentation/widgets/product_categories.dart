import 'package:flutter/material.dart';
import 'package:teste_tecnico_vision/presentation/widgets/product_list.dart';

import '../../models/itens.dart';
class ProductCategory extends StatelessWidget {
  final String category;
  final List<Item> items;
  final Function(Item) onRemoveProduct;

  ProductCategory({required this.category, required this.items, required this.onRemoveProduct});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Brutel',
            ),
          ),
          ProductList(items: items, onRemoveProduct: onRemoveProduct),
        ],
      ),
    );
  }
}
