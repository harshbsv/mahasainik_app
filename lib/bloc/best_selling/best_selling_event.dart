part of 'best_selling_bloc.dart';

@immutable
abstract class BestSellingEvent {}

class BestSellingInitialEvent extends BestSellingEvent {}

class BestSellingLoadingEvent extends BestSellingEvent {}

class BestSellingSuccessEvent extends BestSellingEvent {}

class BestSellingErrorEvent extends BestSellingEvent {}
