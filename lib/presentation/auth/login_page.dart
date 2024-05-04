import 'package:absensi_app/presentation/auth/bloc/login/login_bloc.dart';
import 'package:absensi_app/presentation/home/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/core.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  bool IsShowPassword = false;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(18.0),
        children: [
          const SpaceHeight(50.0),
          Padding(
            padding: const EdgeInsets.all(85.0),
            child: Assets.images.logo.image(),
          ),
          const SpaceHeight(30.0),
          CustomTextField(
            showLabel: false,
            controller: emailController,
            label: 'Email Address',
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Assets.icons.email.svg(),
            ),
          ),
          const SpaceHeight(18.0),
          CustomTextField(
            showLabel: false,
            controller: passwordController,
            label: 'Password',
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Assets.icons.password.svg(),
            ),
            obscureText: true,
          ),
          const SpaceHeight(80.0),
          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                success: (data) => context.pushReplacement(const MainPage()),
                error: (message) => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor: AppColors.red,
                  )
                )
              );
            },
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return Button.filled(
                      onPressed: () {
                        // context.pushReplacement(const MainPage());

                        context.read<LoginBloc>().add(LoginEvent.login(
                            emailController.text, passwordController.text));
                      },
                      label: 'Sign In',
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  // error: (error) => Text(error),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
