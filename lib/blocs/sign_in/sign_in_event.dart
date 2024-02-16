part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SignInTextChangedEvent extends SignInEvent {
  final String emailInput;
  final String passwordInput;

  const SignInTextChangedEvent({
    required this.emailInput,
    required this.passwordInput,
  });

  @override
  List<Object> get props => [emailInput, passwordInput];

  @override
  String toString() =>
      'SignInTextChangedEvent(emailInput: $emailInput, passwordInput: $passwordInput)';
}

class SignInObscurePasswordToggleEvent extends SignInEvent {
  const SignInObscurePasswordToggleEvent();
}

class SignInSubmittedEvent extends SignInEvent {
  final String email;
  final String password;

  const SignInSubmittedEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() =>
      'SignInSubmittedEvent(email: $email, password: $password)';
}
