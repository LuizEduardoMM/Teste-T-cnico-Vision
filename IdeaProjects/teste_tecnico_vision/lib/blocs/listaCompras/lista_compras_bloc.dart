import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:teste_tecnico_vision/models/lista.dart';
import 'package:teste_tecnico_vision/blocs/listaCompras/lista_compra_estado.dart';
import 'package:teste_tecnico_vision/blocs/listaCompras/lista_compras_evento.dart';
import 'package:teste_tecnico_vision/repositories/lista_compra_repositorio.dart';

class ShoppingListBloc extends Bloc<ListaCompraEvento, ShoppingListState> {
  final ListaCompraRepositorio shoppingListRepository;

  ShoppingListBloc({required this.shoppingListRepository}) : super(const ShoppingListState([])) {
    on<CarregarListaCompra>(_carregarListaCompra);
    on<AddListaCompra>(_addListaCompra);
    on<AddProdutoListaCompra>(_onAddProductToShoppingList);
    on<DeleteListaCompra>(_mapDeleteListaCompraToState);
    on<RemoverProdutoListaCompra>(_onRemoveProductFromShoppingList);
  }

  void _onAddProductToShoppingList(AddProdutoListaCompra event, Emitter<ShoppingListState> emit) async {
    final updatedLists = state.listaCompras.map((lista) {
      debugPrint('Adicionando');
      if (lista.nome == event.nomeListaCompra) {
        return ListaCompras(
          nome: lista.nome,
          dataCriacao: lista.dataCriacao,
          itens: [...lista.itens, event.produto],
        );
      }
      return lista;
    }).toList();

    await shoppingListRepository.salvarListaCompras(updatedLists);

    emit(ShoppingListState(updatedLists));

  }

  void _mapDeleteListaCompraToState(DeleteListaCompra event, Emitter<ShoppingListState> emit) async {
    final updatedLists = List<ListaCompras>.from(state.listaCompras)..remove(event.lista);
    await shoppingListRepository.salvarListaCompras(updatedLists);
    emit(ShoppingListState(updatedLists));
  }

  void _addListaCompra(AddListaCompra event, Emitter<ShoppingListState> emit) async {
    final updatedList = List<ListaCompras>.from(state.listaCompras)..add(event.listaCompra);
    await shoppingListRepository.salvarListaCompras(updatedList);
    emit(ShoppingListState(updatedList));
  }

  void _carregarListaCompra(CarregarListaCompra event, Emitter<ShoppingListState> emit) async {
    final shoppingLists = await shoppingListRepository.carregarListaShopping();
    emit(ShoppingListState(shoppingLists));
  }
  void _onRemoveProductFromShoppingList(RemoverProdutoListaCompra event, Emitter<ShoppingListState> emit) async {
    final updatedLists = state.listaCompras.map((lista) {
      if (lista.nome == event.nomeListaCompra) {
        return ListaCompras(
          nome: lista.nome,
          dataCriacao: lista.dataCriacao,
          itens: lista.itens.where((item) => item != event.produto).toList(),
        );
      }
      return lista;
    }).toList();

    await shoppingListRepository.salvarListaCompras(updatedLists);
    emit(ShoppingListState(updatedLists));
  }
}
