import 'package:flutter/material.dart';
import 'package:teste_tecnico_vision/models/itens.dart';
import 'package:teste_tecnico_vision/presentation/widgets/product_list_item.dart';

import 'dialog_edit_item.dart';

class ProductList extends StatelessWidget {
  final List<Item> items;
  final Function(Item) onRemoveProduct;

  const ProductList({required this.items, required this.onRemoveProduct});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return ProductListItem(
          item: item,
          onRemove: () => onRemoveProduct(item),
          onEdit: () {
            showeditItemDialog(context, item);
          },
        );
      }).toList(),
    );
  }

  void showeditItemDialog(BuildContext context, Item item) {
      showEditItemDialog(context, item);

  }
}
