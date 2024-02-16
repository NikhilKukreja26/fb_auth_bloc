import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/sign_up/sign_up_bloc.dart';
import '../constants/constants.dart';
import '../utils/error_dialog.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailAddressController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  final _globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailAddressController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailAddressController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  void _submit(BuildContext context) {
    final form = _globalKey.currentState;

    if (form == null || !form.validate()) return;

    form.save();

    context.read<SignUpBloc>().add(SignUpSubmittedEvent(
          name: _nameController.text,
          email: _emailAddressController.text,
          password: _passwordController.text,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc(),
      child: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state.signUpStatus == SignUpStatus.error) {
            errorDialog(context, state.customError);
          }
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Form(
                    key: _globalKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: ListView(
                      reverse: true,
                      shrinkWrap: true,
                      children: [
                        Image.asset(
                          'assets/images/flutter_logo.png',
                          width: 250,
                          height: 250,
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            labelText: 'Name',
                            prefixIcon: Icon(Icons.account_box),
                          ),
                          onChanged: (value) => context.read<SignUpBloc>().add(
                                SignUpTextChangedEvent(
                                  nameInput: _nameController.text,
                                  emailInput: _emailAddressController.text,
                                  passwordInput: _passwordController.text,
                                  confirmPasswordInput:
                                      _confirmPasswordController.text,
                                ),
                              ),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Name required';
                            }
                            if (value.trim().length < 2) {
                              return 'Name must be at least 2 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          controller: _emailAddressController,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                          ),
                          onChanged: (value) => context.read<SignUpBloc>().add(
                                SignUpTextChangedEvent(
                                  nameInput: _nameController.text,
                                  emailInput: _emailAddressController.text,
                                  passwordInput: _passwordController.text,
                                  confirmPasswordInput:
                                      _confirmPasswordController.text,
                                ),
                              ),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Email required';
                            }
                            if (!RegExp(emailRegex).hasMatch(value)) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: state.obscurePassword,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            filled: true,
                            labelText: 'Password',
                            suffixIcon: IconButton(
                              onPressed: () {
                                context.read<SignUpBloc>().add(
                                    const SignUpObscurePasswordToggleEvent());
                              },
                              icon: state.obscurePassword
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                            ),
                          ),
                          onChanged: (value) => context.read<SignUpBloc>().add(
                                SignUpTextChangedEvent(
                                  nameInput: _nameController.text,
                                  emailInput: _emailAddressController.text,
                                  passwordInput: _passwordController.text,
                                  confirmPasswordInput:
                                      _confirmPasswordController.text,
                                ),
                              ),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Password required';
                            }
                            if (value.trim().length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: state.confirmObscurePassword,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            filled: true,
                            labelText: 'Confirm Password',
                            suffixIcon: IconButton(
                              onPressed: () {
                                context.read<SignUpBloc>().add(
                                    const SignUpConfirmObscurePasswordToggleEvent());
                              },
                              icon: state.confirmObscurePassword
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                            ),
                          ),
                          onChanged: (value) => context.read<SignUpBloc>().add(
                                SignUpTextChangedEvent(
                                  nameInput: _nameController.text,
                                  emailInput: _emailAddressController.text,
                                  passwordInput: _passwordController.text,
                                  confirmPasswordInput:
                                      _confirmPasswordController.text,
                                ),
                              ),
                          validator: (String? value) {
                            if (_passwordController.text != value) {
                              return 'Passwords not match';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: !state.enableSignUpButton
                              ? null
                              : state.signUpStatus == SignUpStatus.submitting
                                  ? null
                                  : () => _submit(context),
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                            ),
                          ),
                          child: Text(
                            state.signUpStatus == SignUpStatus.submitting
                                ? 'Loading...'
                                : 'Sign Up',
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        TextButton(
                          onPressed:
                              state.signUpStatus == SignUpStatus.submitting
                                  ? null
                                  : () => Navigator.of(context).pop(),
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                          ),
                          child: const Text('Already a member? Sign in!'),
                        ),
                      ].reversed.toList(),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
