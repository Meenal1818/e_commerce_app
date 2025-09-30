

import '../../../data(remote)/model/user_profile_model.dart';

abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final UserProfileModel userProfile;
  ProfileLoadedState({required this.userProfile});
}

class ProfileErrorState extends ProfileState {
  final String message;
  ProfileErrorState({required this.message});
}
