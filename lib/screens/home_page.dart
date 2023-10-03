import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_register/screens/register_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              //Log out of Firebase
              FirebaseAuth.instance.signOut().then(
                (onValue) {
                  //Go to registration page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RegisterScreen(),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          "Welcome",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
