import 'package:flutter/material.dart';
import 'package:teste_tecnico_vision/models/lista.dart';
import 'package:teste_tecnico_vision/presentation/screens/shopping_list_detail_page.dart';
import 'package:teste_tecnico_vision/presentation/widgets/dialog_delete_list.dart';
import 'package:teste_tecnico_vision/presentation/widgets/dialog_edit_list.dart';

class ShoppingListItem extends StatelessWidget {
  final ListaCompras shoppingList;

  const ShoppingListItem({
    required this.shoppingList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: Colors.grey[0],
        child: ListTile(
          title: Text(
            '${shoppingList.nome} | Criada em: ${shoppingList.dataCriacao.toLocal().toShortDateString()}',
            style: const TextStyle(

              fontSize: 13,
            ),
          ),
          subtitle: Text(
            '${shoppingList.itens.length} produtos',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Brutel',
              fontSize: 12,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                color: Colors.white,
                onPressed: () {
                  DialogEditList.show(context, shoppingList);
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                color: Colors.white,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => DialogDeleteList(
                      shoppingList: shoppingList,
                    ),
                  );
                },
              ),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShoppingListDetailPage(
                  shoppingList: shoppingList,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

extension on DateTime {
  String toShortDateString() {
    return '${day.toString().padLeft(2, '0')}.${month.toString().padLeft(2, '0')}';
  }
}
