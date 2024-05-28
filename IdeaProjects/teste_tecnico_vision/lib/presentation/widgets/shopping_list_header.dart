import 'package:flutter/material.dart';
import 'package:teste_tecnico_vision/models/lista.dart';
import 'package:teste_tecnico_vision/presentation/widgets/dialog_clean_list.dart';

class ShoppingListHeader extends StatelessWidget {
  final ListaCompras shoppingList;

  const ShoppingListHeader({required this.shoppingList});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(50, 20, 0, 0),
          child: Text(
            'Criada em ${shoppingList.dataCriacao.toLocal().toShortDateString()}',
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'Brutel',
              fontSize: 13,
            ),
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_outlined),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text(
                shoppingList.nome,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Brutel',
                  fontSize: 20,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: IconButton(
                icon: const Icon(Icons.cleaning_services),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) =>
                          DialogCleanList(shoppingList: shoppingList));
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

extension on DateTime {
  String toShortDateString() {
    return '${day.toString().padLeft(2, '0')}.${month.toString().padLeft(2, '0')}';
  }
}
