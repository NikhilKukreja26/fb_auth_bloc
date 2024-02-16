// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthStateChangedEvent extends AuthEvent {
  final fb_auth.User? user;

  const AuthStateChangedEvent({
    this.user,
  });

  @override
  List<Object?> get props => [user];

  @override
  bool get stringify => true;
}

class SignOutRequestedEvent extends AuthEvent {}
