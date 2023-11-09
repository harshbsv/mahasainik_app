part of 'categories_bloc.dart';

@immutable
abstract class CategoriesEvent {}

class CategoriesInitialEvent extends CategoriesEvent {}

class CategoriesLoadingEvent extends CategoriesEvent {}

class CategoriesSuccessEvent extends CategoriesEvent {}

class CategoriesErrorEvent extends CategoriesEvent {}
