import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fb_auth_bloc/core/service_locator.dart';

import '../../models/custom_error.dart';
import '../../models/user_model.dart';
import '../../repositories/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState.initial()) {
    on<FetchUserProfileEvent>(_onFetchUserProfile);
  }

  Future<void> _onFetchUserProfile(
      FetchUserProfileEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(state.copyWith(profileStatus: ProfileStatus.loading));
      final User user =
          await serviceLocator<ProfileRepository>().getProfile(uid: event.uid);
      emit(state.copyWith(
        profileStatus: ProfileStatus.success,
        user: user,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(
        profileStatus: ProfileStatus.error,
        customError: e,
      ));
    }
  }
}
