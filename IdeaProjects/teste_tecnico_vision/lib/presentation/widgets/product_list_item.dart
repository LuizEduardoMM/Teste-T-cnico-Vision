import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste_tecnico_vision/models/itens.dart';
import 'package:teste_tecnico_vision/controller/api_calorias.dart';
import 'package:teste_tecnico_vision/repositories/lista_compra_repositorio.dart';
import 'package:teste_tecnico_vision/models/lista.dart';

class ProductListItem extends StatelessWidget {
  final Item item;
  final VoidCallback onRemove;
  final VoidCallback onEdit;
  final ListaCompras listacompras;

  ProductListItem({
    required this.item,
    required this.onRemove,
    required this.onEdit,
    required this.listacompras,
  });

  final ListaCompraRepositorio listaCompraRepositorio =
      ListaCompraRepositorio();

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Confirmar exclusão",
            style: TextStyle(
              fontFamily: 'Brutel',
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          content: Text(
            "Tem certeza que deseja excluir ${item.nome}?",
            style: const TextStyle(fontFamily: 'Brutel'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.amber,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: const Text(
                  'Cancelar',
                  style: TextStyle(
                    fontFamily: 'Brutel',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                onRemove();
                Navigator.of(context).pop();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.red,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: const Text(
                  'Excluir',
                  style: TextStyle(
                    fontFamily: 'Brutel',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
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
      child: Container(
        padding: const EdgeInsets.all(10),
        child: ListTile(
          leading: Container(
            height: 20,
            width: 20,
            child: Obx(() => Checkbox(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  value: item.isSelected.value,
                  onChanged: (bool? value) {
                    item.isSelected.value = value ?? false;
                  },
                )),
          ),
          title: item.categoria != "Alimentos"
              ? Text(item.nome,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold))
              : FutureBuilder<String>(
                  future: fetchCalories(item.nome),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text('${item.nome}| Calorias: Carregando...',
                          style: const TextStyle(
                              fontSize: 10));
                    } else if (snapshot.hasError) {
                      return Text(
                        item.nome,
                        style: const TextStyle(

                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      );
                    } else {
                      return Text('${item.nome} \n${snapshot.data}',
                          style: const TextStyle(

                              fontSize: 10,
                              fontWeight: FontWeight.bold));
                    }
                  },
                ),
          subtitle: Text(
            'Itens: ${item.quantidade} | R\$${(item.preco ?? 0.0).toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 10,
              fontFamily: 'Brutel',
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              item.preco == null
                  ? const Text(
                      'R\$0.00',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Brutel',
                      ),
                    )
                  : Text(
                      'R\$${((item.preco ?? 0.0) * item.quantidade).toStringAsFixed(2)}',
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
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 15,
                  ),
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
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 15,
                  ),
                  onPressed: () => _showDeleteConfirmationDialog(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
