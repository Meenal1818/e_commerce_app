import 'package:e_commerce_app/ui/bloc/profile/profile_event.dart';
import 'package:e_commerce_app/ui/bloc/profile/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data(remote)/repositary/user_repo.dart';


class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepo userRepo;

  ProfileBloc({required this.userRepo}) : super(ProfileInitialState()) {
    on<FetchProfile>((event, emit) async {
      emit(ProfileLoadingState());
      try {
        final profile = await userRepo.fetchUserProfile();
        emit(ProfileLoadedState(userProfile: profile));
      } catch (e) {
        emit(ProfileErrorState(message: e.toString()));
      }
    });
  }
}
