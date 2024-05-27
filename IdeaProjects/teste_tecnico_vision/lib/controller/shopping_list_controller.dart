import 'package:get/get.dart';
import 'package:teste_tecnico_vision/models/itens.dart';

class ShoppingListController extends GetxController {
  var categorizedItems = <String, List<Item>>{}.obs;
  var totalItems = 0.obs;
  var totalPrice = 0.0.obs;
  var searchTerm = ''.obs;

  void updateCategorizedItems(Map<String, List<Item>> items) {
    categorizedItems.value = items;
    updateTotals();
  }

  void updateSearchTerm(String term) {
    searchTerm.value = term;
  }

  void removeProduct(String category, Item item) {
    if (categorizedItems.containsKey(category)) {
      categorizedItems[category]?.remove(item);
      if (categorizedItems[category]!.isEmpty) {
        categorizedItems.remove(category);
      }
      updateTotals();
    }
  }

  void updateTotals() {
    int itemCount = 0;
    double priceSum = 0.0;
    categorizedItems.forEach((category, items) {
      itemCount += items.length;
      priceSum += items.fold(0.0, (sum, item) => sum + (item.preco ?? 0.0) * item.quantidade);
    });
    totalItems.value = itemCount;
    totalPrice.value = priceSum;
  }

  void sortItemsByName(bool ascending) {
    categorizedItems.updateAll((key, items) {
      items.sort((a, b) => ascending ? a.nome.compareTo(b.nome) : b.nome.compareTo(a.nome));
      return items;
    });
  }

  void sortItemsByPrice(bool ascending) {
    categorizedItems.updateAll((key, items) {
      items.sort((a, b) => ascending ? (a.preco ?? 0).compareTo(b.preco ?? 0) : (b.preco ?? 0).compareTo(a.preco ?? 0));
      return items;
    });
  }
}
