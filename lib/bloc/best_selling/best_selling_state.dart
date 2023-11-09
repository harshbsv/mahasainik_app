part of 'best_selling_bloc.dart';

@immutable
abstract class BestSellingState {}

class BestSellingInitialState extends BestSellingState {}

class BestSellingLoadingState extends BestSellingState {}

class BestSellingSuccessState extends BestSellingState {
  final BestSellingResponseModel responseModel;

  BestSellingSuccessState(this.responseModel);
}

class BestSellingErrorState extends BestSellingState {
  final String error;

  BestSellingErrorState(this.error);
}
