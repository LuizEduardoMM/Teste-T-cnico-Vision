import 'package:flutter/material.dart';

class CustomAppBarHome extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(150);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBar(
          title: const Text(
            'GroceriEasy.',
            style: TextStyle(fontFamily: 'Brutel', fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.amber,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Image.asset('assets/images/Sacola.png',
                width: 220, height: 130),
          ),
        ),
      ],
    );
  }
}
