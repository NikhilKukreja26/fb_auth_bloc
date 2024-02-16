import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/sign_in/sign_in_bloc.dart';
import '../constants/constants.dart';
import '../utils/error_dialog.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late final TextEditingController _emailAddressController;
  late final TextEditingController _passwordController;

  final _globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailAddressController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailAddressController.dispose();
    _passwordController.dispose();
  }

  void _submit(BuildContext context) {
    final form = _globalKey.currentState;

    if (form == null || !form.validate()) return;

    form.save();

    context.read<SignInBloc>().add(SignInSubmittedEvent(
          email: _emailAddressController.text,
          password: _passwordController.text,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInBloc>(
      create: (context) => SignInBloc(),
      child: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state.signInStatus == SignInStatus.error) {
            errorDialog(context, state.customError);
          }
        },
        builder: (context, state) {
          return PopScope(
            canPop: false,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Form(
                      key: _globalKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Image.asset(
                            'assets/images/flutter_logo.png',
                            width: 250,
                            height: 250,
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
                            onChanged: (_) => context.read<SignInBloc>().add(
                                  SignInTextChangedEvent(
                                    emailInput: _emailAddressController.text,
                                    passwordInput: _passwordController.text,
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
                                  context.read<SignInBloc>().add(
                                      const SignInObscurePasswordToggleEvent());
                                },
                                icon: state.obscurePassword
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off),
                              ),
                            ),
                            onChanged: (value) => context
                                .read<SignInBloc>()
                                .add(
                                  SignInTextChangedEvent(
                                    emailInput: _emailAddressController.text,
                                    passwordInput: _passwordController.text,
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
                          ElevatedButton(
                            onPressed: !state.enableSignInButton
                                ? null
                                : state.signInStatus == SignInStatus.submitting
                                    ? null
                                    : () => _submit(context),
                            style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                            ),
                            child: Text(
                                state.signInStatus == SignInStatus.submitting
                                    ? 'Loading...'
                                    : 'Sign In'),
                          ),
                          const SizedBox(height: 10.0),
                          TextButton(
                            onPressed:
                                state.signInStatus == SignInStatus.submitting
                                    ? null
                                    : () {
                                        Navigator.pushNamed(context, '/signUp');
                                      },
                            style: TextButton.styleFrom(
                              textStyle: const TextStyle(
                                fontSize: 20.0,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            child: const Text('Not a member? Sign Up!'),
                          ),
                        ],
                      ),
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
