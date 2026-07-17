import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth/my_auth_provider.dart';
import '../utils/Route/route_helper.dart';
import '../utils/widgets/custom_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKeys = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register Hare')),
      body: Form(
        key: formKeys,
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Image.asset(
                      'assets/icon/writing.png',
                      width: 100,
                      height: 100,
                    ),
                    SizedBox(height: 50),
                    CustomTextField(
                      controller: name,
                      hintText: 'Enter your name: ',
                      prefixIcon: Icons.person_2_outlined,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      controller: email,
                      hintText: 'Enter your email: ',
                      prefixIcon: Icons.email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email address';
                        }
                        if (!value.contains('@')) {
                          return 'Please valid email address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    Consumer<MyAuthProvider>(
                      builder: (context, provider, child) {
                        return CustomTextField(
                          controller: password,
                          isPassword: provider.obSecurePassword,
                          hintText: 'Enter your password: ',
                          prefixIcon: Icons.lock,
                          suffixIcon: IconButton(
                            icon: Icon(
                              provider.obSecurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              provider.passwordVisibility();
                            },
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 8) {
                              return 'Please enter 8 characters password';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      child: Consumer<MyAuthProvider>(
                        builder: (context, provider, child) {
                          return provider.isLoading ? Center(child: CircularProgressIndicator(),):
                          ElevatedButton(
                            onPressed: () {
                              if (formKeys.currentState!.validate()) {
                                provider.authRegister(name.text, email.text, password.text);
                              }
                            },
                            child: Text('Register Now'),
                          );
                        },
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account yet?"),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              RouteHelper.loginScreen,
                            );
                          },
                          child: Text("Sign In"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
