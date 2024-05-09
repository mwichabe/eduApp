import 'package:education_ar/firebase_options.dart';
import 'package:education_ar/screens/home.dart';
import 'package:education_ar/screens/lab_details.dart';
import 'package:education_ar/screens/profile.dart';
import 'package:education_ar/screens/signin.dart';
import 'package:education_ar/screens/signup.dart';
import 'package:education_ar/screens/virtual_lab.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main ()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edu',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
  
      ),
      initialRoute: '/signUp',
      routes: {
        '/signin':(context) => LoginScreen(),
        '/signUp': (context)=> RegistrationScreen(),
        '/home': (context)=> HomeScreen(),
        '/profile': (context)=> Profile(),
        '/virtual_labs' :(context) => VirtualLabsScreen(),

      },
    );
  }
}

