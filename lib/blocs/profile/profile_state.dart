// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_bloc.dart';

enum ProfileStatus {
  initial,
  loading,
  success,
  error,
}

class ProfileState extends Equatable {
  final ProfileStatus profileStatus;
  final User user;
  final CustomError customError;

  const ProfileState({
    required this.profileStatus,
    required this.user,
    required this.customError,
  });

  ProfileState copyWith({
    ProfileStatus? profileStatus,
    User? user,
    CustomError? customError,
  }) {
    return ProfileState(
      profileStatus: profileStatus ?? this.profileStatus,
      user: user ?? this.user,
      customError: customError ?? this.customError,
    );
  }

  factory ProfileState.initial() {
    return ProfileState(
      profileStatus: ProfileStatus.initial,
      user: User.initialUser(),
      customError: const CustomError(),
    );
  }

  @override
  String toString() =>
      'ProfileState(profileStatus: $profileStatus, user: $user, customError: $customError)';

  @override
  List<Object?> get props => [
        profileStatus,
        user,
        customError,
      ];
}
