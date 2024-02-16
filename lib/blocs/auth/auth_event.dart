part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class AuthStateChangedEvent extends AuthEvent {
  final fb_auth.User? user;

  const AuthStateChangedEvent({
    this.user,
  });

  @override
  List<Object?> get props => [user];

  @override
  bool get stringify => true;
}

final class SignOutRequestedEvent extends AuthEvent {}
