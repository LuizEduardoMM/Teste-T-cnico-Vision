import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:teste_tecnico_vision/blocs/listaCompras/lista_compras_evento.dart';
import 'package:teste_tecnico_vision/presentation/screens/initial_screen.dart';
import 'package:teste_tecnico_vision/blocs/listaCompras/lista_compras_bloc.dart';
import 'package:teste_tecnico_vision/repositories/lista_compra_repositorio.dart';
import 'package:flutter/services.dart';

void main() {
  final shoppingListRepository = ListaCompraRepositorio();

  runApp(GroceriEasy(shoppingListRepository: shoppingListRepository));
}

class GroceriEasy extends StatelessWidget {
  final ListaCompraRepositorio shoppingListRepository;

  const GroceriEasy({required this.shoppingListRepository, super.key});

  @override
  Widget build(BuildContext context) {
    DeviceOrientation.portraitUp;
    return BlocProvider(
      create: (context) =>
          ShoppingListBloc(shoppingListRepository: shoppingListRepository)
            ..add(CarregarListaCompra()),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GroceriEasy',
        home: InitialScreen(),
        locale: Locale('pt', 'BR'),
        supportedLocales: [
          Locale('en', 'US'),
          Locale('pt', 'BR'),
        ],
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
  }
}
