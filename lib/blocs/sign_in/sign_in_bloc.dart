import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../core/service_locator.dart';
import '../../models/custom_error.dart';
import '../../repositories/auth_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInState.initial()) {
    on<SignInTextChangedEvent>(_onSignInChanged);
    on<SignInObscurePasswordToggleEvent>(_onObscurePasswordToggled);
    on<SignInSubmittedEvent>(_onSubmitted);
  }

  void _onSignInChanged(
      SignInTextChangedEvent event, Emitter<SignInState> emit) {
    const emailRegex =
        r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
    if (event.emailInput.isNotEmpty &&
        RegExp(emailRegex).hasMatch(event.emailInput) &&
        event.passwordInput.isNotEmpty &&
        event.passwordInput.length > 5) {
      emit(state.copyWith(
        enableSignInButton: true,
      ));
    } else {
      emit(state.copyWith(
        enableSignInButton: false,
      ));
    }
  }

  void _onObscurePasswordToggled(
      SignInObscurePasswordToggleEvent event, Emitter<SignInState> emit) {
    emit(state.copyWith(
      obscurePassword: !state.obscurePassword,
      signInStatus: SignInStatus.initial,
    ));
  }

  Future<void> _onSubmitted(
      SignInSubmittedEvent event, Emitter<SignInState> emit) async {
    try {
      emit(state.copyWith(
        signInStatus: SignInStatus.submitting,
      ));

      await serviceLocator<AuthRepository>()
          .signIn(email: event.email, password: event.password);

      emit(state.copyWith(
        signInStatus: SignInStatus.success,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(
        signInStatus: SignInStatus.error,
        customError: e,
      ));
    }
  }

  @override
  void onTransition(Transition<SignInEvent, SignInState> transition) {
    super.onTransition(transition);
    if (kDebugMode) {
      print('transition: $transition');
      print('current state: ${transition.currentState}');
      print('next state: ${transition.nextState}');
    }
  }
}
