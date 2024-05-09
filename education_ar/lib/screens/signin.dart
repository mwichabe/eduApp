import 'dart:developer';

import 'package:education_ar/screens/home.dart';
import 'package:education_ar/screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email field is required';
                    }
                    if (!RegExp(
                            "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return 'Please Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    RegExp regex = RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!$@#&*~]).{6,}$');
                    if (value!.isEmpty) {
                      return 'Password field cannot be null';
                    }
                    if (!regex.hasMatch(value)) {
                      return 'Password should: \n Have at least 6 characters\n '
                          'Have a symbol \n'
                          'Have an uppercase \n'
                          'Have a numeric number \n'
                          'eg. Education@1';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: () {
                          signIn(
                              _emailController.text, _passwordController.text);
                        },
                        child: const Text('Login'),
                      ),
                const SizedBox(height: 18),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegistrationScreen(),
                        ),
                      );
                    },
                    child: const Text('Don\'t have an account? Register here.'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        var userCredential = await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        setState(() {
          isLoading = false;
        });

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));

        Fluttertoast.showToast(
          msg: 'Login Successful',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          timeInSecForIosWeb: 1,
          fontSize: 16,
        );
      } catch (e) {
        log(e.toString());

        setState(() {
          isLoading = false;
        });

        String errorMessage = 'An error occurred during sign-in.';
        if (e is FirebaseAuthException) {
          switch (e.code) {
            case 'invalid-email':
              errorMessage = 'Invalid email address.';
              break;
            case 'user-not-found':
              errorMessage =
                  'User not found. Please check your credentials.';
              break;
            case 'wrong-password':
              errorMessage =
                  'Invalid password. Please check your password and try again.';
              break;
            default:
              errorMessage =
                  'An error occurred during sign-in. Please try again later.';
          }
        }
        Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          timeInSecForIosWeb: 1,
          fontSize: 16,
        );
      }
    }
  }
}
