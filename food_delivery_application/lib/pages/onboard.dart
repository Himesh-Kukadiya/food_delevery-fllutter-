import 'package:flutter/material.dart';
import 'package:food_delivery_application/Widgets/content_model.dart';
import 'package:food_delivery_application/Widgets/TextStyles.dart';
import 'package:food_delivery_application/pages/bottomnav.dart';
import 'package:food_delivery_application/service/shared_pref.dart';
import 'package:food_delivery_application/pages/login.dart';

class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  String? Email = "";
  getthesharedpref() async{
    Email = await SharedPreferenceHelper().getUserEmail();
    setState(() {});
  }

  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    // getthesharedpref();
    // setState(() {
    //   if(Email!=null) {
    //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const BottomNav()));
    //   }
    //   else{

    //   }
    // });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column( 
        children: [ 
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
              return Padding(
                padding: const EdgeInsets.only(top: 100.0, left: 20.0, right: 20.0),
                child: Column( 
                  children: [ 
                    Image.asset(
                      contents[i].image, 
                      height: 400, 
                      width: MediaQuery.of(context).size.width/1.5, fit: BoxFit.fill,
                    ),
                    const SizedBox(height: 30.0,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(contents[i].title, style: TextStyles.SamiBoldTextFeildStyle(true), textAlign: TextAlign.center,)
                    ),
                    const SizedBox(height: 30.0,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(contents[i].description, style: TextStyles.LightTextFeildStyle(true), textAlign: TextAlign.center,)),
                  ],
                )
              );
            }),
          ),
          Row( 
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(contents.length, (index) => 
                buildDot(index, context),
              )
          ),
          GestureDetector(
            onTap: () {
              if(currentIndex == contents.length - 1) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LogIn()));
              }
              _controller.nextPage(duration: const Duration(milliseconds: 100), curve: Curves.bounceIn);
            },
            child: Container( 
              decoration: BoxDecoration( 
                color: Colors.black,
                borderRadius: BorderRadius.circular(15)
              ),
              height: 50.0,
              margin: const EdgeInsets.all(40.0),
              width: double.infinity,
              child: Center( 
                child: Text(
                  currentIndex == contents.length - 1 ? "Start" : "Next", 
                  style: TextStyles.ButtonTextFeildStyle(false),),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buildDot (int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 18:7,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration( 
        borderRadius: BorderRadius.circular(6), 
        color: Colors.black38
      ),
    );
  }
}