import 'package:flutter/material.dart';

class SearchBarList extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isFocused;
  final VoidCallback onSearch;

  const SearchBarList({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.isFocused,
    required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          enabled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          labelText: 'Pesquisar lista de compras',
          labelStyle: TextStyle(
            color: isFocused ? Colors.black : Colors.grey,
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: onSearch,
          ),
        ),
        onSubmitted: (_) => onSearch(),
        style: TextStyle(
          color: isFocused ? Colors.black : Colors.grey,
        ),
      ),
    );
  }
}
