part of 'nearby_stores_bloc.dart';

@immutable
abstract class NearbyStoresState {}

class NearbyStoresInitalState extends NearbyStoresState {}

class NearbyStoresLoadingState extends NearbyStoresState {}

class NearbyStoresSuccessState extends NearbyStoresState {
  final NearbyStoresResponseModel responseModel;

  NearbyStoresSuccessState(this.responseModel);
}

class NearbyStoresErrorState extends NearbyStoresState {
  final String errorMessage;

  NearbyStoresErrorState(this.errorMessage);
}
