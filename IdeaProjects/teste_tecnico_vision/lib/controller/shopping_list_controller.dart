import 'package:get/get.dart';
import 'package:teste_tecnico_vision/models/itens.dart';

class ShoppingListController extends GetxController {
  var categorizedItems = <String, List<Item>>{}.obs;
  var totalItems = 0.obs;
  var totalPrice = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    categorizedItems.forEach((category, items) {
      items.forEach((item) {
        item.isSelected.listen((_) {
          sortItemsByCategory(category);
        });
      });
    });
  }

  void updateCategorizedItems(Map<String, List<Item>> items) {
    categorizedItems.value = items;
    updateTotals();

    items.forEach((category, itemList) {
      itemList.forEach((item) {
        item.isSelected.listen((_) {
          sortItemsByCategory(category);
        });
      });
    });
  }

  void updateSearchTerm(String term) {

  }

  void removeProduct(String category, Item item) {
    categorizedItems[category]?.remove(item);
    updateTotals();
  }

  void updateTotals() {
    int totalItemsCount = 0;
    double totalPriceSum = 0.0;

    categorizedItems.forEach((category, items) {
      totalItemsCount += items.length;
      totalPriceSum += items.fold(0, (sum, item) => sum + ((item.preco ?? 0.0) * item.quantidade));
    });

    totalItems.value = totalItemsCount;
    totalPrice.value = totalPriceSum;
  }

  void sortItemsByCategory(String category) {
    var items = categorizedItems[category];
    if (items != null) {
      items.sort((a, b) {
        if (a.isSelected.value == b.isSelected.value) {
          return a.nome.compareTo(b.nome);
        }
        return a.isSelected.value ? 1 : -1;
      });
      categorizedItems[category] = items;
      categorizedItems.refresh();
    }
  }

  void sortItemsByName(bool ascending) {
    categorizedItems.forEach((category, items) {
      items.sort((a, b) {
        int compareResult = a.nome.compareTo(b.nome);
        if (!ascending) compareResult = -compareResult;
        if (a.isSelected.value == b.isSelected.value) return compareResult;
        return a.isSelected.value ? 1 : -1;
      });
    });
    categorizedItems.refresh();
  }

  void sortItemsByPrice(bool ascending) {
    categorizedItems.forEach((category, items) {
      items.sort((a, b) {
        int compareResult = (a.preco ?? 0.0).compareTo(b.preco ?? 0.0);
        if (!ascending) compareResult = -compareResult;
        if (a.isSelected.value == b.isSelected.value) return compareResult;
        return a.isSelected.value ? 1 : -1;
      });
    });
    categorizedItems.refresh();
  }

}
