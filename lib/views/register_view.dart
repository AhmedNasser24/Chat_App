import 'dart:developer';

import 'package:chat_app/constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../cubits/auto_cubit/auth_cubit.dart';
import '../helper/show_snack_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_circle_avatar.dart';
import '../widgets/custom_textfield.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});
  static String id = 'Register id';

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String email = '';

  String password = '';

  final _key = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterSucceed) {
          isLoading = false;
          Navigator.pop(context);
        } else if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterFailure) {
          isLoading = false;
          showSnackBar(context, state.errorMessage);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Form(
                key: _key,
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
                            'Register',
                            style:
                                TextStyle(fontSize: 22, color: kSecondaryColor),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        validator: (value) {
                          if (value!.isEmpty) {
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter your password';
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
                        text: 'Register',
                        onTap: () {
                          if (_key.currentState!.validate()) {
                            BlocProvider.of<AuthCubit>(context)
                                .registerUser(email: email, password: password);
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
                            'Already have an account ',
                            style:
                                TextStyle(fontSize: 13, color: kSecondaryColor),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              '  Login',
                              style: TextStyle(
                                  fontSize: 13, color: kSecondaryColor),
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
        );
      },
    );
  }
}
