// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

final class SignUpTextChangedEvent extends SignUpEvent {
  final String nameInput;
  final String emailInput;
  final String passwordInput;
  final String confirmPasswordInput;

  const SignUpTextChangedEvent({
    required this.nameInput,
    required this.emailInput,
    required this.passwordInput,
    required this.confirmPasswordInput,
  });

  @override
  List<Object> get props => [
        nameInput,
        emailInput,
        passwordInput,
        confirmPasswordInput,
      ];

  @override
  String toString() =>
      'SignUpTextChangedEvent(nameInput: $nameInput, emailInput: $emailInput, passwordInput: $passwordInput, confirmPasswordInput: $confirmPasswordInput)';
}

final class SignUpObscurePasswordToggleEvent extends SignUpEvent {
  const SignUpObscurePasswordToggleEvent();
}

final class SignUpConfirmObscurePasswordToggleEvent extends SignUpEvent {
  const SignUpConfirmObscurePasswordToggleEvent();
}

final class SignUpSubmittedEvent extends SignUpEvent {
  final String name;
  final String email;
  final String password;

  const SignUpSubmittedEvent({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [name, email, password];

  @override
  String toString() =>
      'SignUpSubmittedEvent(name: $name, email: $email, password: $password)';
}
