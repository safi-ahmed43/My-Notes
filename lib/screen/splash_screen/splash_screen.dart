import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_notes/providers/auth/my_auth_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<MyAuthProvider>(context, listen: false).nextScreen();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Image.asset('assets/icon/note-taking.png',width: 120,),
              ),
            Text('My Notes',
            style: GoogleFonts.blackOpsOne(fontSize: 40, fontWeight: FontWeight.bold,color: Colors.lightBlueAccent),
            ),
            Spacer(),
            Text('Welcome to My Notes',
            style: GoogleFonts.oswald(fontWeight: FontWeight.bold,color: Colors.blue),
            ),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }
}
