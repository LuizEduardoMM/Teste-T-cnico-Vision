import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/itens.dart';
import 'package:teste_tecnico_vision/controller/api_calorias.dart';

class ProductListItem extends StatelessWidget {
  final Item item;
  final VoidCallback onRemove;
  final VoidCallback onEdit;

  ProductListItem({
    required this.item,
    required this.onRemove,
    required this.onEdit,
  });

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
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
        leading: Obx(() => Checkbox(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          value: item.isSelected.value,
          onChanged: (bool? value) {
            item.isSelected.value = value ?? false;
          },
        )),
        title: item.categoria != "Alimentos"
            ? Text(item.nome, style: const TextStyle(fontFamily: 'Brutel',fontSize: 12))
            : FutureBuilder<String>(
          future: fetchCalories(item.nome),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('${item.nome}| Calorias: Carregando...',
                  style: const TextStyle(
                      fontFamily: 'Brutel', fontSize: 10));
            } else if (snapshot.hasError) {
              return Text(item.nome,style: TextStyle(fontFamily: 'Brutel',fontSize: 12),);
            } else {
              return Text('${item.nome} | ${snapshot.data}',
                  style: const TextStyle(
                      fontFamily: 'Brutel', fontSize: 10));
            }
          },
        ),
        subtitle: Text(
          'Quantidade: ${item.quantidade} | Unidade: R\$${(item.preco ?? 0.0).toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 10,
            fontFamily: 'Brutel',
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (item.preco != null)
              Text(
                'Total: R\$${((item.preco ?? 0.0) * item.quantidade).toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'Brutel',
                ),
              ),
            Container(
              height: 20,
              width: 20,
              margin: const EdgeInsets.only(left: 30),
              child: IconButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.all(0),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                icon: const Icon(Icons.edit, color: Colors.white, size: 15,),
                onPressed: onEdit,
              ),
            ),
            Container(
              height: 20,
              width: 20,
              margin: const EdgeInsets.only(left: 10),
              child: IconButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.all(0),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                icon: const Icon(Icons.delete, color: Colors.white, size: 15,),
                onPressed: () => _showDeleteConfirmationDialog(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
