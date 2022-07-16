import 'package:employee_flutter/screens/staff_screen.dart';
import 'package:flutter/material.dart';
import 'package:employee_flutter/screens/welcome_screen.dart';
import 'package:employee_flutter/screens/login_screen.dart';
import 'package:employee_flutter/screens/registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';

// email- nikhil@email.com
// password- nikhil12


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Employee());
}

class Employee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id :(context)=> WelcomeScreen(),
        LoginScreen.id :(context)=> LoginScreen(),
        RegistrationScreen.id :(context)=> RegistrationScreen(),
        StaffScreen.id : (context) => StaffScreen(),


      },
    );
  }
}
