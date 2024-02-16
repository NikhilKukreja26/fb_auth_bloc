import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (kDebugMode) {
          print('listener: $state');
        }
        if (state.authStatus == AuthStatus.unauthenticated) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/signIn',
            (route) {
              if (kDebugMode) {
                print('route.settings.name: ${route.settings.name}');
                print('ModalRoute: ${ModalRoute.of(context)!.settings.name}');
              }

              return route.settings.name ==
                      ModalRoute.of(context)!.settings.name
                  ? true
                  : false;
            },
          );
        } else if (state.authStatus == AuthStatus.authenticated) {
          Navigator.of(context).pushNamed('/home');
        }
      },
      builder: (context, state) {
        if (kDebugMode) {
          print('builder: $state');
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
