import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_tecnico_vision/blocs/listaCompras/lista_compras_evento.dart';
import 'package:teste_tecnico_vision/presentation/screens/initial_screen.dart';
import 'package:teste_tecnico_vision/blocs/listaCompras/lista_compras_bloc.dart';
import 'package:teste_tecnico_vision/repositories/lista_compra_repositorio.dart';


void main() {
  final shoppingListRepository = ListaCompraRepositorio();

  runApp(GroceriEasy(shoppingListRepository: shoppingListRepository));
}

class GroceriEasy extends StatelessWidget {
  final ListaCompraRepositorio shoppingListRepository;

  const GroceriEasy({required this.shoppingListRepository, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShoppingListBloc(shoppingListRepository: shoppingListRepository)..add(CarregarListaCompra()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GroceriEasy',
        home: InitialScreen(),
      ),
    );
  }
}
