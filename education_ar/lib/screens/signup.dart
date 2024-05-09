import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_ar/models/user.dart';
import 'package:education_ar/screens/home.dart';
import 'package:education_ar/screens/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool isLoading = false;
  // controllers
  final _auth = FirebaseAuth.instance;
  //form key
  final _formKey = GlobalKey<FormState>();
  //editing Controllers
  final TextEditingController _nameEditingController= TextEditingController();
  final TextEditingController _emailEditingController= TextEditingController();
  final TextEditingController phoneEditingController= TextEditingController();
  final TextEditingController _passwordEditingController= TextEditingController();
  final TextEditingController _confirmPasswordEditingController= TextEditingController();

  String? _selectedPaymentMethod;
  late String preferredDinnerNumber;
  bool isSelected = false;

  final List<String> paymentMethods = [
    'Cash',
    'Credit Card',
    'Check',
  ];
  String generatePreferredDinnerNumber() {
    DateTime now = DateTime.now();
    return 'D${now.year}${now.month}${now.day}${now.hour}${now.minute}';
  }
  @override
  void initState() {
    super.initState();
    // Initialize the preferredDinnerNumber in the initState method
    preferredDinnerNumber = generatePreferredDinnerNumber();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Registration'),
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
                  decoration: InputDecoration(labelText: 'Name'),
                  controller: _nameEditingController,
                   validator: (value)
                   {
                     if(value!.isEmpty){
                       return ("Required");
                     }
                     if(!RegExp("^[A-Za-z]{3,}").hasMatch(value))
                     {
                       return("Name cannot be less than 3 characters.");
                     }
                     return null;
                   },
                ),
                 TextFormField(
                  decoration: InputDecoration(labelText: 'Phone'),
                   controller: phoneEditingController,
                ),
                 TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                   controller: _emailEditingController,
                   validator: (value)
                   {
                     if(value!.isEmpty)
                     {
                       return('Email field is required');
                     }
                     //regEx for email
                     if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                         .hasMatch(value)){return("Please Enter a valid email");}
                     return null;
                   },
                ),

                DropdownButton<String>(
                  value: _selectedPaymentMethod,
                  hint: const Text('Select Preferred Payment Method'),
                  onChanged: (String? value) {
                    setState(() {
                      _selectedPaymentMethod = value;
                    });
                  },
                  items: paymentMethods.map((String method) {
                    return DropdownMenuItem<String>(
                      value: method,
                      child: Text(method),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 20),
                TextFormField(
                  obscureText: true,
                  validator: (value)
                  {
                    RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!$@#&*~]).{6,}$');
                    if(value!.isEmpty)
                    {
                      return('Password field cannot be null');
                    }
                    //regEx for password field
                    if(!regex.hasMatch(value)){
                      return ('Password should: \n'
                          ' Have at least 6 characters\n '
                          'Have a symbol \n'
                          'Have an uppercase \n'
                          'Have a numeric number \n'
                          'eg. Education@1');
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Password'),
                  controller: _passwordEditingController,
                ),
                TextFormField(
                  validator: (value)
                  {

                    if(value!.isEmpty)
                    {
                      return('Password field cannot be empty');
                    }
                    //regEx for password field
                    if(value != _passwordEditingController.text) {
                      return 'Your password does not match';
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Password'),
                  controller: _confirmPasswordEditingController,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        register(_emailEditingController.text,_passwordEditingController.text);
                      },
                      child: Text('Register'),
                    ),
                    const SizedBox(width: 8,),
                    const Text('Already have an account',style: TextStyle(
                      color: Colors.black
                    ),),
                    SizedBox(width: 10,),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
                      },
                      child: const Text('Log In?',style: TextStyle(
                        color: Colors.amber
                      ),),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  postDetailsToFirestore()async
  {
    // calling firestore
    FirebaseFirestore firebaseFirestore= FirebaseFirestore.instance;
    User? user= _auth.currentUser;
    //calling usermodel
    UserModelOne userModel=UserModelOne(uid: '');
    // sending content
    userModel.email=user!.email;
    userModel.uid=user.uid;
    userModel.name=_nameEditingController.text;
    userModel.phone= phoneEditingController.text;
    userModel.preferredPaymentMethod= _selectedPaymentMethod;
    userModel.earnedPoints=0;
    userModel.isSameAsMailingAddress=isSelected;
    userModel.preferredDinnerNumber=preferredDinnerNumber;
    await firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .set(userModel.toMap());
    Navigator.pushReplacement(
        (context), MaterialPageRoute(builder: (context)=>HomeScreen()));
  }
  void register(String email,String password) async
  {
    if (_formKey.currentState!.validate())
    {
      setState(() {
        isLoading=true;
      }
      );
      await _auth.createUserWithEmailAndPassword(
          email: _emailEditingController.text,
          password: _passwordEditingController.text)
          .then((value) => {
        postDetailsToFirestore()
      }).catchError((e)
      {log(e!.message);
      // Show error message
      String errorMessage = 'An error occurred during sign-up.';
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'weak-password':
            errorMessage =
            'The password is too weak. Please use a stronger password.';
            break;
          case 'email-already-in-use':
            errorMessage =
            'The email address is already in use. Please choose a different email.';
            break;
          default:
            errorMessage =
            'An error occurred while creating your account. Please try again later.';
        }
      }
      Fluttertoast.showToast(
        msg:errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        timeInSecForIosWeb: 1,
        fontSize: 16,);
      });

    }
    setState(() {
      isLoading=false;
    });
  }
}
