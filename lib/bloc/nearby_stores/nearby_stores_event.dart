part of 'nearby_stores_bloc.dart';

@immutable
abstract class NearbyStoresEvent {}

class NearbyStoresLoadingEvent extends NearbyStoresEvent {
  final double latitude, longitude;

  NearbyStoresLoadingEvent(this.latitude, this.longitude);
}

class NearbyStoresSuccessEvent extends NearbyStoresEvent {}

class NearbyStoresErrorEvent extends NearbyStoresEvent {}
