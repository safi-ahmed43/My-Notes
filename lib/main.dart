import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/firebase_options.dart';
import 'package:my_notes/providers/auth/my_auth_provider.dart';
import 'package:my_notes/providers/note/note_provider.dart';
import 'package:my_notes/utils/Route/route_helper.dart';
import 'package:my_notes/utils/widgets/app_theme.dart';
import 'package:provider/provider.dart';

final navigatorKeys=GlobalKey<NavigatorState>();
final scaffoldMessengerKeys=GlobalKey<ScaffoldMessengerState>();
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MyAuthProvider()),
        ChangeNotifierProvider(create: (context) => NoteProvider())
      ],
      child: MaterialApp(
        navigatorKey: navigatorKeys,
        scaffoldMessengerKey: scaffoldMessengerKeys,
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        routes: RouteHelper.myRoute(),
        onGenerateRoute:(settings) =>  RouteHelper.onGenarateRoute(settings),
      ),
    );
  }
}
