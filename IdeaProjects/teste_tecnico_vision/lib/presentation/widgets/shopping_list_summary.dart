import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste_tecnico_vision/controller/shopping_list_controller.dart';

class ShoppingListSummary extends StatelessWidget {
  final ShoppingListController controller;

  const ShoppingListSummary({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
      child: Row(
        children: [
          Obx(() {
            return Text(
              "Produtos (${controller.totalItems.value})",
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Brutel',
                fontSize: 14,
              ),
            );
          }),
          Expanded(
            child: Obx(() {
              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: Text(
                  "Total: R\$${controller.totalPrice.value.toStringAsFixed(2)}",
                  textAlign: TextAlign.right,
                ),
              );
            }),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'Nome (A-Z)':
                  controller.sortItemsByName(true);
                  break;
                case 'Nome (Z-A)':
                  controller.sortItemsByName(false);
                  break;
                case 'Preço (Crescente)':
                  controller.sortItemsByPrice(true);
                  break;
                case 'Preço (Decrescente)':
                  controller.sortItemsByPrice(false);
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'Nome (A-Z)',
                  child: Text('Nome (A-Z)'),
                ),
                const PopupMenuItem(
                  value: 'Nome (Z-A)',
                  child: Text('Nome (Z-A)'),
                ),
                const PopupMenuItem(
                  value: 'Preço (Crescente)',
                  child: Text('Preço (Crescente)'),
                ),
                const PopupMenuItem(
                  value: 'Preço (Decrescente)',
                  child: Text('Preço (Decrescente)'),
                ),
              ];
            },
            icon: const Icon(Icons.sort),
          ),
        ],
      ),
    );
  }
}
