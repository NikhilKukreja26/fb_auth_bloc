import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fb_auth_bloc/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

import '../../core/service_locator.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late final StreamSubscription<fb_auth.User?> authSubscription;

  AuthBloc() : super(AuthState.unknown()) {
    authSubscription = serviceLocator<AuthRepository>().user.listen(
      (fb_auth.User? user) {
        add(AuthStateChangedEvent(user: user));
      },
    );

    on<AuthStateChangedEvent>((event, emit) {
      if (event.user != null) {
        emit(state.copyWith(
          user: event.user,
          authStatus: AuthStatus.authenticated,
        ));
      } else {
        emit(state.copyWith(
          user: null,
          authStatus: AuthStatus.unauthenticated,
        ));
      }
    });

    on<SignOutRequestedEvent>((event, emit) async {
      await serviceLocator<AuthRepository>().signOut();
    });
  }

  @override
  Future<void> close() {
    authSubscription.cancel();
    return super.close();
  }
}
