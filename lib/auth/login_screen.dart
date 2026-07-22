import 'package:flutter/material.dart';
import 'package:my_notes/providers/auth/my_auth_provider.dart';
import 'package:my_notes/utils/Route/route_helper.dart';
import 'package:my_notes/utils/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email =TextEditingController();
  TextEditingController password =TextEditingController();
  GlobalKey<FormState> formKeys= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Hare'),
      ),
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
                    SizedBox(height: 50,),
                    Image.asset('assets/icon/writing.png',
                      width: 100,
                      height: 100,
                    ),
                    SizedBox(height: 50,),
                    CustomTextField(
                      controller: email,
                      hintText: 'Enter your email: ',
                      prefixIcon: Icons.email,
                      validator: (value){
                        if(value== null || value.isEmpty){
                          return 'Please enter email address';
                        }
                        if(!value.contains('@')){
                          return 'Please valid email address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10,),
                    Consumer<MyAuthProvider>(
                        builder: (context, provider, child) {
                          return CustomTextField(
                            controller: password,
                            isPassword: provider.obSecurePassword,
                            hintText: 'Enter your password: ',
                            prefixIcon: Icons.lock,
                            suffixIcon: IconButton(
                              icon: Icon(provider.obSecurePassword? Icons.visibility_off:Icons.visibility),
                              onPressed: (){
                                provider.passwordVisibility();
                              },
                            ),
                            validator: (value){
                              if(value== null || value.isEmpty){
                                return 'Please enter your password';
                              }
                              if(value.length<8){
                                return 'Please enter 8 characters password';
                              }
                              return null;
                            },
                          );
                        }
                    ),
                    SizedBox(height: 25,),
                    SizedBox(
                      width: double.infinity,
                      child: Consumer<MyAuthProvider>(
                        builder: (context, provider, child) {
                          return provider.isLoading? Center(child: CircularProgressIndicator(),):
                          ElevatedButton(
                              onPressed: (){
                                if(formKeys.currentState!.validate()){
                                  provider.authLogin(email.text, password.text);
                                }
                              },
                              child: Text('Login Now')
                          );
                        }
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(onPressed: (){
                          Navigator.pushNamed(context, RouteHelper.forgetScreen);
                        }, child: Text('Forgot your password!'))
                      ],
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account yet?"),
                        TextButton(
                            onPressed: (){
                              Navigator.pushNamed(context, RouteHelper.registerScreen);
                            },
                            child: Text("Sign Up")
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
        ]
        ),
      ),
    );
  }
}
