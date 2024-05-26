import 'package:equatable/equatable.dart';
import 'package:teste_tecnico_vision/models/itens.dart';
import 'package:teste_tecnico_vision/models/lista.dart';
abstract class ListaCompraEvento extends Equatable {
  const ListaCompraEvento();

  @override
  List<Object> get props => [];
}

class CarregarListaCompra extends ListaCompraEvento {}

class AddListaCompra extends ListaCompraEvento {
  final ListaCompras listaCompra;

  const AddListaCompra(this.listaCompra);

  @override
  List<Object> get props => [listaCompra];
}

class AddProdutoListaCompra extends ListaCompraEvento {
  final String nomeListaCompra;
  final Item produto;

  const AddProdutoListaCompra(this.nomeListaCompra, this.produto);

  @override
  List<Object> get props => [nomeListaCompra, produto];
}
class FiltrarListaCompras extends ListaCompraEvento {
  final String query;

  const FiltrarListaCompras(this.query);

  @override
  List<Object> get props => [query];
}
class DeleteListaCompra extends ListaCompraEvento {
  final ListaCompras lista;

  const DeleteListaCompra(this.lista);

  @override
  List<Object> get props => [lista];
}
class RemoverProdutoListaCompra extends ListaCompraEvento {
  final String nomeListaCompra;
  final Item produto;

  RemoverProdutoListaCompra(this.nomeListaCompra, this.produto);
}
