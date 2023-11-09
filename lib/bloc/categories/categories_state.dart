part of 'categories_bloc.dart';

@immutable
abstract class CategoriesState {}

class CategoriesInitialState extends CategoriesState {}

class CategoriesLoadingState extends CategoriesState {}

class CategoriesSuccessState extends CategoriesState {
  final List<CategoriesResponseModel> responseModel;

  CategoriesSuccessState(this.responseModel);
}

class CategoriesErrorState extends CategoriesState {
  final String error;

  CategoriesErrorState(this.error);
}
