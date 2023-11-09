part of 'update_profile_bloc.dart';

@immutable
abstract class UpdateProfileEvent {}

class UpdateProfileInitialEvent extends UpdateProfileEvent {}

class UpdateProfileLoadingEvent extends UpdateProfileEvent {}

class UpdateProfileSuccessEvent extends UpdateProfileEvent {}

class UpdateProfileErrorEvent extends UpdateProfileEvent {}
