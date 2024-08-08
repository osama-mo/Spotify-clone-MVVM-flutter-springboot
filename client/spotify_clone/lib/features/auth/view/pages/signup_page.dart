import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/core/widgets/Loader.dart';
import 'package:spotify_clone/features/auth/repositories/auth_remote_repository.dart';

import '../../../../core/theme/app_pallete.dart';
import '../../viewmodel/auth_viewmodel.dart';
import '../../../../core/widgets/CustomTextField.dart';
import '../widgets/auth_gradient_button.dart';
import 'signin_page.dart';

class SignUpPage extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SignUpPage(),
      );
  const SignUpPage({Key? key}) : super(key: key);
  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
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
    final isLoading = ref.watch(authViewModelProvider.select((val) => val.isLoading == true ));

    ref.listen(authViewModelProvider, (_,state) {
         state?.when(data: (data) {
           Navigator.push(context, MaterialPageRoute(builder:(c) => const SignInPage()));
         }, error: (error, _) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
         }, loading: (){});
    });
    return Scaffold(
        body: isLoading
            ? Loader()
            : Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextField(
                        hintText: 'Name',
                        controller: nameController,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        hintText: 'Email',
                        controller: emailController,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
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
                            if (formKey.currentState!.validate()) {
                              ref.read(authViewModelProvider.notifier).signup(
                                    nameController.text,
                                    emailController.text,
                                    passwordController.text,
                                  );
                            }
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
                )));
  }
}
