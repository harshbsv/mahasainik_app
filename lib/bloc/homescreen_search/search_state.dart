part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchSuccessState extends SearchState {
  final SearchResponseModel responseModel;

  SearchSuccessState(this.responseModel);
}

class SearchErrorState extends SearchState {
  final String errorString;

  SearchErrorState(this.errorString);
}
