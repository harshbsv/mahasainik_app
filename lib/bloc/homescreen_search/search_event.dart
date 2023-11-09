part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchInitialEvent extends SearchEvent {}

class SearchProductsEvent extends SearchEvent {
  final String searchQuery;

  SearchProductsEvent(this.searchQuery);
}

class SearchLoadingEvent extends SearchEvent {}

class SearchSuccessEvent extends SearchEvent {}

class SearchErrorEvent extends SearchEvent {}
