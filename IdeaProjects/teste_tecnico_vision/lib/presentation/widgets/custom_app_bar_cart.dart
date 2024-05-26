import 'package:flutter/material.dart';

class CustomAppBarCart extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'GroceriEasy.',
            style: TextStyle(fontFamily: 'Brutel', fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.amber,
        ),
      ],
    );
  }
}
