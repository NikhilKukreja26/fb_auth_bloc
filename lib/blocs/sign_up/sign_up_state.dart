// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'sign_up_bloc.dart';

enum SignUpStatus {
  initial,
  submitting,
  success,
  error,
}

class SignUpState extends Equatable {
  final SignUpStatus signUpStatus;
  final bool obscurePassword;
  final bool confirmObscurePassword;
  final bool enableSignUpButton;
  final CustomError customError;

  const SignUpState({
    this.signUpStatus = SignUpStatus.initial,
    this.obscurePassword = true,
    this.confirmObscurePassword = true,
    this.enableSignUpButton = false,
    required this.customError,
  });

  factory SignUpState.initial() {
    return const SignUpState(
      customError: CustomError(),
    );
  }

  SignUpState copyWith({
    SignUpStatus? signUpStatus,
    bool? obscurePassword,
    bool? confirmObscurePassword,
    bool? enableSignUpButton,
    CustomError? customError,
  }) {
    return SignUpState(
      signUpStatus: signUpStatus ?? this.signUpStatus,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      confirmObscurePassword:
          confirmObscurePassword ?? this.confirmObscurePassword,
      enableSignUpButton: enableSignUpButton ?? this.enableSignUpButton,
      customError: customError ?? this.customError,
    );
  }

  @override
  List<Object> get props => [
        signUpStatus,
        obscurePassword,
        confirmObscurePassword,
        enableSignUpButton,
        customError,
      ];

  @override
  String toString() {
    return 'SignUpState(signUpStatus: $signUpStatus, obscurePassword: $obscurePassword, confirmObscurePassword: $confirmObscurePassword, enableSignInButton: $enableSignUpButton, customError: $customError)';
  }
}
