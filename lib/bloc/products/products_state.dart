part of 'products_bloc.dart';

@immutable
abstract class ProductsState {}

class ProductsInitialState extends ProductsState {}

class ProductsLoadingState extends ProductsState {}

class ProductsSuccessState extends ProductsState {
  final ProductsResponseModel responseModel;

  ProductsSuccessState(this.responseModel);
}

class ProductsErrorState extends ProductsState {
  final String error;

  ProductsErrorState(this.error);
}
