import 'package:flutter/material.dart';

class ShoppingListCreateTile extends StatelessWidget {
  final VoidCallback onTap;

  const ShoppingListCreateTile({Key? key, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      color: Colors.grey[0],
      child: ListTile(
        title: const Text(
          'Cria uma nova lista de compras',
          style: TextStyle(fontFamily: 'Brutel'),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.add),
          color: Colors.white,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.amber),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          onPressed: onTap,
        ),
      ),
    );
  }
}
