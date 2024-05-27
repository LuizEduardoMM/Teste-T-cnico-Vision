import 'package:flutter/material.dart';
import '../../models/itens.dart';

class ProductListItem extends StatelessWidget {
  final Item item;
  final VoidCallback onRemove;

  ProductListItem({required this.item, required this.onRemove});

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmar exclusão"),
          content: Text("Tem certeza que deseja excluir ${item.nome}?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                onRemove();
                Navigator.of(context).pop();
              },
              child: Text("Excluir"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        title: Text(item.nome),
        subtitle: Text(
          'Quantidade: ${item.quantidade} | Unidade: R\$${(item.preco ?? 0.0).toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 12,
            fontFamily: 'Brutel',
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (item.preco != null)
              Text('Total: R\$${((item.preco ?? 0.0) * item.quantidade).toStringAsFixed(2)}'),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed:()=> _showDeleteConfirmationDialog(context),
            ),
          ],
        ),
      ),
    );
  }
}
