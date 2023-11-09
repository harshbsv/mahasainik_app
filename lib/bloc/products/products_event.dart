part of 'products_bloc.dart';

@immutable
abstract class ProductsEvent {}

class ProductsInitialEvent extends ProductsEvent {}

class ProductsLoadingEvent extends ProductsEvent {}

class ProductsSuccessEvent extends ProductsEvent {}

class ProductsErrorEvent extends ProductsEvent {}
