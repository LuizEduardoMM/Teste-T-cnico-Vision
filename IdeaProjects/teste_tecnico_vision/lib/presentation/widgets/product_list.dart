import 'package:flutter/material.dart';
import 'package:teste_tecnico_vision/models/itens.dart';
import 'package:teste_tecnico_vision/models/lista.dart';
import 'package:teste_tecnico_vision/presentation/widgets/product_list_item.dart';

import 'dialog_edit_item.dart';

class ProductList extends StatelessWidget {
  final List<Item> items;
  final Function(Item) onRemoveProduct;
  final ListaCompras listacompras;

  const ProductList(
      {required this.items,
      required this.onRemoveProduct,
      required this.listacompras});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return ProductListItem(
          listacompras:listacompras,
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
