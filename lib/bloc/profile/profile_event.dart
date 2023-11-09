part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class ProfileInitialEvent extends ProfileEvent {}

class ProfileLoadingEvent extends ProfileEvent {}

class ProfileSuccessEvent extends ProfileEvent {}

class ProfileUpdatedEvent extends ProfileEvent {}

class ProfileErrorEvent extends ProfileEvent {}
