import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_tecnico_vision/models/lista.dart';
import 'package:teste_tecnico_vision/models/itens.dart';
import 'package:teste_tecnico_vision/presentation/widgets/custom_app_bar_cart.dart';
import 'package:teste_tecnico_vision/presentation/widgets/item_search_bar.dart';
import 'package:teste_tecnico_vision/presentation/widgets/product_categories.dart';
import 'package:teste_tecnico_vision/controller/shopping_list_controller.dart';
import 'package:teste_tecnico_vision/blocs/listaCompras/lista_compras_bloc.dart';
import 'package:teste_tecnico_vision/blocs/listaCompras/lista_compras_evento.dart';
import 'package:teste_tecnico_vision/blocs/listaCompras/lista_compra_estado.dart';
import 'package:teste_tecnico_vision/presentation/widgets/shopping_list_header.dart';
import 'package:teste_tecnico_vision/presentation/widgets/shopping_list_summary.dart';

class ShoppingListDetailPage extends StatelessWidget {
  final ListaCompras shoppingList;
  final ShoppingListController controller = Get.put(ShoppingListController());

  ShoppingListDetailPage({required this.shoppingList});

  Map<String, List<Item>> _categorizeItems(List<Item> items) {
    final Map<String, List<Item>> categorizedItems = {};
    for (var item in items) {
      if (!categorizedItems.containsKey(item.categoria)) {
        categorizedItems[item.categoria] = [];
      }
      categorizedItems[item.categoria]!.add(item);
    }
    return categorizedItems;
  }

  @override
  Widget build(BuildContext context) {
    controller.updateCategorizedItems(_categorizeItems(shoppingList.itens));

    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: CustomAppBarCart(),
      body: BlocConsumer<ShoppingListBloc, ShoppingListState>(
        listener: (context, state) {
          final updatedShoppingList = state.listaCompras.firstWhere(
              (list) => list.nome == shoppingList.nome,
              orElse: () => shoppingList);
          controller.updateCategorizedItems(
              _categorizeItems(updatedShoppingList.itens));
        },
        builder: (context, state) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ShoppingListHeader(shoppingList: shoppingList),
                ShoppingListSummary(
                  controller: controller,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ItemSearchBar(
                            controller: controller, shoppingList: shoppingList),
                        Obx(() {
                          return Column(
                            children: controller.categorizedItems.entries
                                .map((entry) {
                              return ProductCategory(
                                listacompras: shoppingList,
                                category: entry.key,
                                items: entry.value,
                                onRemoveProduct: (item) {
                                  controller.removeProduct(entry.key, item);
                                  BlocProvider.of<ShoppingListBloc>(context)
                                      .add(RemoverProdutoListaCompra(
                                          shoppingList.nome, item));
                                },
                              );
                            }).toList(),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
