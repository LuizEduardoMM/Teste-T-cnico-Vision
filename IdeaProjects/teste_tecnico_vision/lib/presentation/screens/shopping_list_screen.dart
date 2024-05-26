import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_tecnico_vision/blocs/listaCompras/lista_compras_bloc.dart';
import 'package:teste_tecnico_vision/blocs/listaCompras/lista_compra_estado.dart';
import 'package:teste_tecnico_vision/presentation/widgets/custom_app_bar.dart';
import 'package:teste_tecnico_vision/presentation/widgets/dialog_create_list.dart';
import 'package:teste_tecnico_vision/presentation/widgets/search_bar.dart' as custom;
import 'package:teste_tecnico_vision/presentation/widgets/create_list_tile.dart';
import 'package:teste_tecnico_vision/presentation/widgets/shopping_list_item.dart';


class ShoppingListPage extends StatefulWidget {
  @override
  _ShoppingListPageState createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  String _filterQuery = "";

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearch() {
    setState(() {
      _filterQuery = _controller.text.toLowerCase();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarHome(),
      body: Container(
        color: Colors.amber,
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                  ),
                ),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Lista de Compras',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Brutel',
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    custom.SearchBarList(
                      controller: _controller,
                      focusNode: _focusNode,
                      isFocused: _isFocused,
                      onSearch: _onSearch,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                      child: ShoppingListCreateTile(
                        onTap: (){
                          DialogCreateList.show(context);
                        },
                      ),
                    ),
                    Expanded(
                      child: BlocBuilder<ShoppingListBloc, ShoppingListState>(
                        builder: (context, state) {
                          final listaParaMostrar = state.listaCompras.where((lista) {
                            return lista.nome.toLowerCase().contains(_filterQuery);
                          }).toList();
                          if (listaParaMostrar.isEmpty) {
                            return const Center(
                                child: Text('Nenhuma lista cadastrada.'));
                          }
                          return ListView.builder(
                            itemCount: listaParaMostrar.length,
                            itemBuilder: (context, index) {
                              final shoppingList = listaParaMostrar[index];
                              return ShoppingListItem(shoppingList: shoppingList);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
