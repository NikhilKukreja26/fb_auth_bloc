import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../constants/constants.dart';
import '../../core/service_locator.dart';
import '../../models/custom_error.dart';
import '../../repositories/auth_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpState.initial()) {
    on<SignUpTextChangedEvent>(_onSignUpTextChanged);
    on<SignUpObscurePasswordToggleEvent>(_onObscurePasswordToggled);
    on<SignUpConfirmObscurePasswordToggleEvent>(
        _onConfirmObscurePasswordToggled);
    on<SignUpSubmittedEvent>(_onSubmitted);
  }

  void _onSignUpTextChanged(
      SignUpTextChangedEvent event, Emitter<SignUpState> emit) {
    if (event.nameInput.isNotEmpty &&
        event.nameInput.length > 1 &&
        event.emailInput.isNotEmpty &&
        RegExp(emailRegex).hasMatch(event.emailInput) &&
        event.passwordInput.isNotEmpty &&
        event.passwordInput.length > 5 &&
        event.passwordInput == event.confirmPasswordInput) {
      emit(state.copyWith(
        enableSignUpButton: true,
      ));
    } else {
      emit(state.copyWith(
        enableSignUpButton: false,
      ));
    }
  }

  void _onObscurePasswordToggled(
      SignUpObscurePasswordToggleEvent event, Emitter<SignUpState> emit) {
    emit(state.copyWith(
      obscurePassword: !state.obscurePassword,
      signUpStatus: SignUpStatus.initial,
    ));
  }

  void _onConfirmObscurePasswordToggled(
      SignUpConfirmObscurePasswordToggleEvent event,
      Emitter<SignUpState> emit) {
    emit(state.copyWith(
      confirmObscurePassword: !state.confirmObscurePassword,
      // signUpStatus: SignUpStatus.initial,
    ));
  }

  Future<void> _onSubmitted(
      SignUpSubmittedEvent event, Emitter<SignUpState> emit) async {
    try {
      emit(state.copyWith(
        signUpStatus: SignUpStatus.submitting,
      ));

      await serviceLocator<AuthRepository>().signUp(
        name: event.name,
        email: event.email,
        password: event.password,
      );

      emit(state.copyWith(
        signUpStatus: SignUpStatus.success,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(
        signUpStatus: SignUpStatus.error,
        customError: e,
      ));
    }
  }

  @override
  void onTransition(Transition<SignUpEvent, SignUpState> transition) {
    super.onTransition(transition);
    if (kDebugMode) {
      print('transition: $transition');
      print('transition: ${transition.currentState}');
      print('transition: ${transition.nextState}');
    }
  }
}
