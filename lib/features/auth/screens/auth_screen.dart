import 'package:amazon/common/widgets/custom_button.dart';
import 'package:amazon/common/widgets/custom_textfield.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/auth_service.dart';

enum Auth { signIn, signUp }

class AuthScreen extends ConsumerStatefulWidget {
  static const String path = '/auth';
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  Auth auth = Auth.signUp;
  final singUpFormKey = GlobalKey<FormState>();
  final singInFormKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final AuthService authService = AuthService();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  Future<void> signUpUser() async {
    if (singUpFormKey.currentState!.validate()) {
      await authService.signUpUser(
        context: context,
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      );
      setState(() {
        auth = Auth.signIn;
      });
    }
  }

  Future<void> signInUser() async {
    if (singInFormKey.currentState!.validate()) {
      await authService.signInUser(
        context: context,
        email: emailController.text,
        password: passwordController.text,
        ref: ref,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: const Text(
                  'Create Account',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signUp,
                  onChanged: (value) => setState(() => auth = value!),
                  groupValue: auth,
                ),
              ),
              if (auth == Auth.signUp)
                Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  color: Colors.white,
                  child: Form(
                    key: singUpFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: nameController,
                          hintText: 'Name',
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: emailController,
                          hintText: 'Email',
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: passwordController,
                          hintText: 'Password',
                          obscure: true,
                        ),
                        const SizedBox(height: 10),
                        CustomButton(
                          label: 'Sign Up',
                          onTap: () async {
                            signUpUser();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: const Text(
                  'Sign In',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signIn,
                  onChanged: (value) => setState(() => auth = value!),
                  groupValue: auth,
                ),
              ),
              if (auth == Auth.signIn)
                Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  color: Colors.white,
                  child: Form(
                    key: singInFormKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: emailController,
                          hintText: 'Email',
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: passwordController,
                          hintText: 'Password',
                        ),
                        const SizedBox(height: 10),
                        CustomButton(
                          label: 'Sign In',
                          onTap: () async {
                            signInUser();
                          },
                        )
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
