part of 'sign_in_bloc.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

final class SignInTextChangedEvent extends SignInEvent {
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

final class SignInObscurePasswordToggleEvent extends SignInEvent {
  const SignInObscurePasswordToggleEvent();
}

final class SignInSubmittedEvent extends SignInEvent {
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
