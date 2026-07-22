import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_notes/utils/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

import '../providers/auth/my_auth_provider.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController email = TextEditingController();
  GlobalKey<FormState> formKey= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot your password',
        style: TextStyle(fontSize: 20),
        ),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(12),
          children: [
            SizedBox(height: 60,),
            Image.asset('assets/icon/forgot.png',height: 100,),
            SizedBox(height: 60,),
            CustomTextField(controller: email, hintText: 'Enter your email'),
            SizedBox(height: 20,),
            Consumer<MyAuthProvider>(
              builder: (context, provider, child) {
                return provider.isLoading ? Center(child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.blueAccent, size: 55),) :
                ElevatedButton(
                    onPressed: (){
                      provider.authForgotPassword(email.text);
                    },
                    child: Text('Forgot your password'));
              }
            )
          ],
        ),
      ),
    );
  }
}
