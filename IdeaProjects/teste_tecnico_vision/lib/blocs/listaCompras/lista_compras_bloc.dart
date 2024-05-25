import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:equatable/equatable.dart';
import 'package:teste_tecnico_vision/models/lista.dart';
import 'package:teste_tecnico_vision/blocs/listaCompras/lista_compra_estado.dart';
import 'package:teste_tecnico_vision/blocs/listaCompras/lista_compras_evento.dart';
import 'package:teste_tecnico_vision/models/itens.dart';
import 'package:teste_tecnico_vision/repositories/lista_compra_repositorio.dart';

class ShoppingListBloc extends Bloc<ListaCompraEvento, ShoppingListState> {
  final ListaCompraRepositorio shoppingListRepository;

  ShoppingListBloc({required this.shoppingListRepository}) : super(const ShoppingListState([])) {
    on<CarregarListaCompra>(_carregarListaCompra);
    on<AddListaCompra>(_addListaCompra);
    on<AddProdutoListaCompra>(_onAddProductToShoppingList);
  }

  void _carregarListaCompra(CarregarListaCompra event, Emitter<ShoppingListState> emit) async {
    final shoppingLists = await shoppingListRepository.carregarListaShopping();
    emit(ShoppingListState(shoppingLists));
  }

  void _addListaCompra(AddListaCompra event, Emitter<ShoppingListState> emit) async {
    final updatedList = List<ListaCompras>.from(state.listaCompras)..add(event.listaCompra);
    await shoppingListRepository.salvarListaCompras(updatedList);
    emit(ShoppingListState(updatedList));
  }

  void _onAddProductToShoppingList(AddProdutoListaCompra event, Emitter<ShoppingListState> emit) async {
    final updatedLists = state.listaCompras.map((list) {
      if (list.nome == event.nomeListaCompra) {
        return ListaCompras(
          nome: list.nome,
          dataCriacao: list.dataCriacao,
          itens: List<Item>.from(list.itens)..add(event.produto),
        );
      }
      return list;
    }).toList();
    await shoppingListRepository.salvarListaCompras(updatedLists);
    emit(ShoppingListState(updatedLists));
  }
}
