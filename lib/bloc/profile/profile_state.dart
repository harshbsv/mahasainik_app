part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileSuccessState extends ProfileState {
  final UserProfileResponseModel userProfileResponseModel;

  ProfileSuccessState(this.userProfileResponseModel);
}

class ProfileUpdatedState extends ProfileState {}

class ProfileErrorState extends ProfileState {
  final String errorMessage;

  ProfileErrorState(this.errorMessage);
}
