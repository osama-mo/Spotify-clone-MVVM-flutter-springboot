

import 'package:flutter/material.dart';
import 'package:spotify_clone/features/home/repositories/auth_remote_repository.dart';

import '../../../../core/theme/app_pallete.dart';
import '../widgets/auth_field.dart';
import '../widgets/auth_gradient_button.dart';
import 'signin_page.dart';

class SignUpPage extends StatefulWidget {
    static route() => MaterialPageRoute(
        builder: (context) => const SignUpPage(),
      );
  const SignUpPage({Key? key}) : super(key: key);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                AuthField(
                  hintText: 'Name',
                  controller: nameController,
                ),
                const SizedBox(
                  height: 15,
                ),
                AuthField(
                  hintText: 'Email',
                  controller: emailController,
                ),
                const SizedBox(
                  height: 15,
                ),
                AuthField(
                  hintText: 'Password',
                  controller: passwordController,
                  isObscure: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                AuthGradientButton(
                    text: "Sign Up!",
                    onPressed: () {
                      AuthRemoteRepository().signup(
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text);
                    }),
                const SizedBox(
                  height: 20,
                ),
                 GestureDetector(
                    onTap: () {
                      Navigator.push(context, SignInPage.route());
                    },
                  child: RichText(
                    text: TextSpan(
                        text: 'Already have an account? ',
                        style: Theme.of(context).textTheme.titleMedium,
                        children: const [
                          TextSpan(
                            text: 'Sign In',
                            style: TextStyle(
                                color: AppPallete.gradient2,
                                fontWeight: FontWeight.bold),
                          )
                        ]),
                  ),
                )
              ],
            ),
          )

    ));
  }
}
