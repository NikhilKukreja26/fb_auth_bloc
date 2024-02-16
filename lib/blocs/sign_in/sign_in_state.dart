// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sign_in_bloc.dart';

enum SignInStatus {
  initial,
  submitting,
  success,
  error,
}

class SignInState extends Equatable {
  final SignInStatus signInStatus;
  final bool obscurePassword;
  final bool enableSignInButton;
  final CustomError customError;

  const SignInState({
    this.signInStatus = SignInStatus.initial,
    this.obscurePassword = true,
    this.enableSignInButton = false,
    required this.customError,
  });

  factory SignInState.initial() {
    return const SignInState(
      customError: CustomError(),
    );
  }

  SignInState copyWith({
    SignInStatus? signInStatus,
    bool? obscurePassword,
    bool? enableSignInButton,
    CustomError? customError,
  }) {
    return SignInState(
      signInStatus: signInStatus ?? this.signInStatus,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      enableSignInButton: enableSignInButton ?? this.enableSignInButton,
      customError: customError ?? this.customError,
    );
  }

  @override
  List<Object> get props => [
        signInStatus,
        obscurePassword,
        enableSignInButton,
        customError,
      ];

  @override
  String toString() {
    return 'SignInState(signInStatus: $signInStatus, obscurePassword: $obscurePassword, enableSignInButton: $enableSignInButton, customError: $customError)';
  }
}
