// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

final class FetchUserProfileEvent extends ProfileEvent {
  final String uid;

  const FetchUserProfileEvent({
    required this.uid,
  });

  @override
  String toString() => 'FetchUserProfileEvent(uid: $uid)';

  @override
  List<Object> get props => [uid];
}
