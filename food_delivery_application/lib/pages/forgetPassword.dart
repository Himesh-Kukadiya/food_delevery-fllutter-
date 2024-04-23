import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_application/Widgets/TextStyles.dart';
import 'package:food_delivery_application/pages/signup.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formkey = GlobalKey<FormState>();
  String email = "";
  final TextEditingController _emailController = TextEditingController();

  resetPassword () async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password Reset Emails has been sent !", style: TextStyles.SamiBoldTextFeildStyle(false)),
          backgroundColor: const Color.fromARGB(255, 28, 28, 28),
        ),
      );
    } on FirebaseException catch(e) {
      if(e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("User does not exist", style: TextStyles.SamiBoldTextFeildStyle(false)),
            backgroundColor: Colors.red.shade300,
          ),
        );
      }
    }
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 100.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20,),
              Text(
                "Password Recovery",
                style: TextStyles.HeaderTextFeildStyle(false),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20,),
              Text(
                "Enter your Mail",
                style: TextStyles.SamiBoldTextFeildStyle(false),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40,),
              Form(
                key: _formkey,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white70, width: 2.0),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email';
                      } else if (!isValidEmail(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    style: TextStyles.SamiBoldTextFeildStyle(false),
                    decoration: const InputDecoration(
                      hintText: "Email",
                      hintStyle: TextStyle(fontSize: 18.0, color: Colors.white),
                      prefixIcon: Icon(Icons.email, color: Colors.white70, size: 30.0,),
                      border: InputBorder.none,
                      
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40,),
              GestureDetector(
                onTap: () { 
                  if(_formkey.currentState!.validate()) {
                    setState(() {
                      email = _emailController.text;
                    });
                    resetPassword();
                  }
                },
                child: Container(
                  width: 140,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Text("Send Email", style: TextStyles.ButtonTextFeildStyle(true)),
                  ),
                ),
              ),
              const SizedBox(height: 40.0,),
              Row( 
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ 
                  Text("Don’t have an account? ",
                    style: TextStyles.SamiBoldTextFeildStyle(false),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUp()));
                    },
                    child: const Text("Sign up",
                      style: TextStyle( 
                        color: Colors.white70,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}