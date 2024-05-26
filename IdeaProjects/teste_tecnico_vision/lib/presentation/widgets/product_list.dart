import 'package:flutter/material.dart';

import 'package:teste_tecnico_vision/presentation/widgets/product_list_item.dart';

import '../../models/itens.dart';

class ProductList extends StatelessWidget {
  final List<Item> items;
  final Function(Item) onRemoveProduct;

  ProductList({required this.items, required this.onRemoveProduct});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return ProductListItem(
          item: item,
          onRemove: () => onRemoveProduct(item),
        );
      }).toList(),
    );
  }
}


