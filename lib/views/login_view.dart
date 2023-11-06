import 'dart:developer';

import 'package:chat_app/constants.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/views/register_view.dart';
import 'package:chat_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../bloc/auth_bloc/auth_bloc.dart';
import '../helper/show_snack_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_circle_avatar.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static String id = 'Login view';
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String email = '';
  String password = '';
  final _loginkey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginSucceed) {
          isLoading = false;
          Navigator.pushNamed(context, ChatView.id, arguments: email);
        } else if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginFailure) {
          showSnackBar(context, state.errorMessage);
          isLoading = false;
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Form(
              key: _loginkey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    const CustomCircleAvatar(),
                    const Text(
                      'Scolar chat',
                      style: TextStyle(
                          fontFamily: 'Pacifico',
                          color: kSecondaryColor,
                          fontSize: 30),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          'Login',
                          style:
                              TextStyle(fontSize: 22, color: kSecondaryColor),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      validator: (email) {
                        if (email!.isEmpty) {
                          return 'Enter your email';
                        }
                        return null;
                      },
                      hintText: 'Email',
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      validator: (password) {
                        if (password!.isEmpty) {
                          return 'enter your password';
                        }
                        return null;
                      },
                      hintText: 'Password',
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    CustomButton(
                      text: 'Login',
                      onTap: () {
                        if (_loginkey.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(context).add(LoginEvent(email: email, password: password));
                        }
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'don\'t have an account ',
                          style:
                              TextStyle(fontSize: 13, color: kSecondaryColor),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, RegisterView.id);
                          },
                          child: const Text(
                            '  Register',
                            style:
                                TextStyle(fontSize: 13, color: kSecondaryColor),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
