import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_register/screens/home_page.dart';
import 'package:firebase_login_register/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Variables
  String? email, password;
  bool loadingStatus = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Login Screen"),
      ),
      body: loadingStatus
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: const EdgeInsets.all(16),
              alignment: Alignment.center,
              child: Form(
                key: _formKey,
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            return value!.contains("@")
                                ? null
                                : "Type valid Email address";
                          },
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                          decoration: const InputDecoration(
                            hintText: "Enter Email",
                            labelText: "Email",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            return value!.length >= 6
                                ? null
                                : "Your password must be at least 6 characters";
                          },
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                          decoration: const InputDecoration(
                            hintText: "Enter Password",
                            labelText: "Password",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              login();
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.grey.shade800,
                            ),
                            child: const Text("Login"),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              //Redirect to registration page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const RegisterScreen(),
                                ),
                              );
                            },
                            child: const Text("Don't have an account yet?"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  // Login method
  void login() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loadingStatus = true;
      });
      //Login from firebase
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!)
          .then((user) {
        // Loading status
        setState(() {
          loadingStatus = false;
        });
        Fluttertoast.showToast(msg: "Login successful");
        // Go to home page
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => const HomePage(),
            ),
            (Route<dynamic> route) => false);
      }).catchError((onError) {
        //Error status
        setState(() {
          loadingStatus = false;
        });
        Fluttertoast.showToast(msg: "Error: $onError");
      });
    }
  }
}
