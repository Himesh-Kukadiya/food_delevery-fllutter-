import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_application/Widgets/TextStyles.dart';
import 'package:food_delivery_application/admin/admin_login.dart';
import 'package:food_delivery_application/pages/bottomnav.dart';
import 'package:food_delivery_application/pages/forgetPassword.dart';
import 'package:food_delivery_application/service/shared_pref.dart';
import 'package:food_delivery_application/pages/signup.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formkey = GlobalKey<FormState>();
  String email = "", password = "";
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
  userLogin() async {
    if(password != null && email != null ) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar((SnackBar(content: Text("Login Successfully", style: TextStyles.SamiBoldTextFeildStyle(false),), backgroundColor: const Color.fromARGB(255, 28, 28, 28),)));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => BottomNav())); 
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("User does not exist", style: TextStyles.SamiBoldTextFeildStyle(false)),
              backgroundColor: Colors.red.shade300,
            ),
          );
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Invalid credentials", style: TextStyles.SamiBoldTextFeildStyle(false)),
              backgroundColor: Colors.red.shade300,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Invalid User & Password.", style: TextStyles.SamiBoldTextFeildStyle(false)),
              backgroundColor: Colors.red.shade300,
            ),
          );
        }
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.5,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 15, 15, 15),
                      Color(0xFF000000),
                    ],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: const Text(""),
              ),
              Container(
                margin: const EdgeInsets.only(top: 80.0, left: 25.0, right: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.asset('images/Logo.png'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                        width: MediaQuery.of(context).size.width / 1.1,
                        height: MediaQuery.of(context).size.height / 1.8,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Login",
                                style: TextStyles.HeaderTextFeildStyle(true),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  hintStyle: TextStyles.SamiBoldTextFeildStyle(true),
                                  prefixIcon: const Icon(Icons.email_outlined),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an email';
                                  } else if (!isValidEmail(value)) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: TextStyles.SamiBoldTextFeildStyle(true),
                                  prefixIcon: const Icon(Icons.password_outlined),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a password';
                                  } else if (value.length < 6) {
                                    return 'Password must be at least 6 characters long';
                                  }
                                  return null; // Return null if the input is valid
                                },
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPassword()));
                                },
                                child: Container(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    "Forget Password?",
                                    style: TextStyles.SamiBoldTextFeildStyle(true),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (_formkey.currentState!.validate()) {
                                    email = _emailController.text;
                                    password = _passwordController.text;
                                    setState(() {}); // No need to set anything, just trigger a rebuild
                                    userLogin();
                                  }
                                },
                                child: Material(
                                  borderRadius: BorderRadius.circular(5),
                                  elevation: 5.0,
                                  child: Container(
                                    width: 250,
                                    padding: const EdgeInsets.symmetric(vertical: 6),
                                    decoration: BoxDecoration(
                                        color: Colors.black87,
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Center(child: Text("Login", style: TextStyles.ButtonTextFeildStyle(false),)),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30.0,),
                              GestureDetector( 
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminLogin()));
                                },
                                child: Text("I am admin", style: TextStyles.SamiBoldTextFeildStyle(true),),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    GestureDetector(
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => SignUp()))
                        },
                        child: Text(
                          "Don’t have an account? sign up",
                          style: TextStyles.SamiBoldTextFeildStyle(true),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}