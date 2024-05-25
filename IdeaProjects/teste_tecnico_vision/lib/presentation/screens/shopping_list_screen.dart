import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_tecnico_vision/blocs/listaCompras/lista_compras_bloc.dart';
import 'package:teste_tecnico_vision/blocs/listaCompras/lista_compra_estado.dart';
import 'package:teste_tecnico_vision/blocs/listaCompras/lista_compras_evento.dart';
import 'shopping_list_detail_page.dart';
import 'package:teste_tecnico_vision/models/lista.dart';

class ShoppingListPage extends StatefulWidget {
  @override
  _ShoppingListPageState createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: Stack(children: [
          AppBar(
            title: const Text(
              'GroceriEasy.',
              style:
                  TextStyle(fontFamily: 'Brutel', fontWeight: FontWeight.bold),
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
              ))
        ]),
      ),
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
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        decoration: InputDecoration(
                          enabled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          labelText: 'Nome da lista de compras',
                          labelStyle: TextStyle(
                            color: _isFocused ? Colors.black : Colors.grey,
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              if (_controller.text.isNotEmpty) {
                                final newList = ListaCompras(
                                  nome: _controller.text,
                                  dataCriacao: DateTime.now(),
                                  itens: [],
                                );
                                context
                                    .read<ShoppingListBloc>()
                                    .add(AddListaCompra(newList));
                                _controller.clear();
                              }
                            },
                          ),
                        ),
                        style: TextStyle(
                          color: _isFocused ? Colors.black : Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: BlocBuilder<ShoppingListBloc, ShoppingListState>(
                        builder: (context, state) {
                          if (state.listaCompras.isEmpty) {
                            return const Center(
                                child: Text('Nenhuma lista cadastrada.'));
                          }
                          return ListView.builder(
                            itemCount: state.listaCompras.length,
                            itemBuilder: (context, index) {
                              final shoppingList = state.listaCompras[index];
                              return Container(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 8, 10, 8),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  color: Colors.grey[0],
                                  child: ListTile(
                                    title: Text(
                                      '${shoppingList.nome} | Criada em: ${shoppingList.dataCriacao.toLocal().toShortDateString()}',
                                      style: TextStyle(fontFamily: 'Brutel'),
                                    ),
                                    subtitle: Text(
                                        '${shoppingList.itens.length} produtos',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Brutel')),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        debugPrint(
                                            'Deletando lista de compras');
                                      },
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    style: ListTileStyle.list,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ShoppingListDetailPage(
                                            shoppingList: shoppingList,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
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

extension on DateTime {
  String toShortDateString() {
    return '${day.toString().padLeft(2, '0')}.${month.toString().padLeft(2, '0')}';
  }
}
