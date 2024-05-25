import 'package:equatable/equatable.dart';
import 'package:teste_tecnico_vision/models/lista.dart';

class ShoppingListState extends Equatable {
  final List<ListaCompras> listaCompras;

  const ShoppingListState(this.listaCompras);

  @override
  List<Object> get props => [listaCompras];
}
