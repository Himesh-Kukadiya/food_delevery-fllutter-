// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_delivery_application/service/database.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_application/Widgets/TextStyles.dart';
import 'package:food_delivery_application/pages/bottomnav.dart';
import 'package:food_delivery_application/pages/login.dart';
import 'package:food_delivery_application/service/shared_pref.dart';
import 'package:random_string/random_string.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();
  String name="", email="", password="";
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  Registration() async {
    if(password != null && email != null && name != null) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar((SnackBar(content: Text("Registered Successfully", style: TextStyles.SamiBoldTextFeildStyle(false),), backgroundColor: const Color.fromARGB(255, 28, 28, 28),)));
        

        String Id = randomAlphaNumeric(10);
        Map<String, dynamic> addUserInfo = {
          "Name": _nameController.text,
          "Email": _emailController.text,
          "Wallet": "0",
          "Id": Id,
        };
        await DatabaseMethods().addUser(addUserInfo, Id);
        await SharedPreferenceHelper().saveUserId(Id);
        await SharedPreferenceHelper().saveUserName(name);
        await SharedPreferenceHelper().saveUserEmail(email);
        await SharedPreferenceHelper().saveUserWallet("0");

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomNav()));
      }on FirebaseException catch(e) {
        if(e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar((SnackBar(content: Text("Password provide is too Weak", style: TextStyles.SamiBoldTextFeildStyle(false),), backgroundColor: Colors.red.shade300,))); 
        }
        else if(e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar((SnackBar(content: Text("Email already in use", style: TextStyles.SamiBoldTextFeildStyle(false),), backgroundColor: Colors.red.shade300,))); 
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
                    const SizedBox(height: 20,),
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
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                const SizedBox(height: 20,),
                                Text("Sign up", style: TextStyles.HeaderTextFeildStyle(true),),
                                const SizedBox(height: 20,),
                                TextFormField(
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                      hintText: 'Name',
                                      hintStyle: TextStyles.SamiBoldTextFeildStyle(true),
                                      prefixIcon: const Icon(Icons.person_2_outlined),),
                                  validator: (value){
                                    if( value == null || value.isEmpty) {
                                      return 'please Enter Name';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20,),
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
                                const SizedBox(height: 20,),
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
                                const SizedBox(height: 50,),
                                GestureDetector(
                                  onTap: () async {
                                    if(_formkey.currentState!.validate()) {
                                      setState(() {
                                        email = _emailController.text;
                                        name = _nameController.text;
                                        password = _passwordController.text;
                                      });
                                      Registration();
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
                                      child: Center(child: Text("SIGN UP", style: TextStyles.ButtonTextFeildStyle(false),)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 70,),
                    GestureDetector(
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => LogIn()))
                        },
                        child: Text("Already have an account? login", style: TextStyles.SamiBoldTextFeildStyle(true),)
                    )
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