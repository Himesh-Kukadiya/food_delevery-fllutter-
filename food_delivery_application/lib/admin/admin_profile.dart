import 'package:flutter/material.dart';
import 'package:food_delivery_application/Widgets/TextStyles.dart';
import 'package:food_delivery_application/admin/admin_login.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({super.key});

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  String Name = "Sardar Patel";
  String Email = "patelsir@gmail.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        child: Column( 
          children: [ 
            Stack( 
              children: [ 
                Container( 
                  padding: const EdgeInsets.only(top: 45.0, left: 20.0, right: 20.0),
                  height: MediaQuery.of(context).size.height / 4.2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration( 
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(MediaQuery.of(context).size.width, 105.0))
                  ),
                ),
                const SizedBox(height: 100,),
                Center(
                  child: Container( 
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 6),
                    child: Material( 
                      elevation: 10.0,
                      borderRadius: BorderRadius.circular(60),
                      child: ClipRRect( 
                        // borderRadius: BorderRadius.circular(60),
                        borderRadius: BorderRadius.circular(60),
                        child: Image.asset('images/boy.png', height: 120, width: 120, fit: BoxFit.cover,),
                      ),
                    ),
                  ),
                ),
                Padding(padding: const EdgeInsets.only(top: 90.0), child: Row( 
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [ 
                    Text(Name, style: TextStyles.SamiBoldTextFeildStyle(true),)
                ],),)
              ],
            ),
            const SizedBox(height: 30.0,),
            Container( 
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Material( 
                elevation: 2.0,
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 25, 25, 25),
                child: Container( 
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                  decoration: const BoxDecoration( 
                    color: Color.fromARGB(255, 25, 25, 25),
                  ),
                  child: Row( 
                    children: [ 
                      const Icon(Icons.person, color: Colors.white,),
                      const SizedBox(width: 20.0,),
                      Column( 
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Name", style: TextStyles.SamiBoldTextFeildStyle(false),),
                          Text(Name, style: TextStyles.SamiBoldTextFeildStyle(false),),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30.0,),
            Container( 
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Material( 
                elevation: 2.0,
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 25, 25, 25),
                child: Container( 
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                  decoration: const BoxDecoration( 
                    color: Color.fromARGB(255, 25, 25, 25),
                  ),
                  child: Row( 
                    children: [ 
                      const Icon(Icons.email, color: Colors.white,),
                      const SizedBox(width: 20.0,),
                      Column( 
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Email", style: TextStyles.SamiBoldTextFeildStyle(false),),
                          Text(Email, style: TextStyles.SamiBoldTextFeildStyle(false),),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30.0,),
            GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AdminLogin()));
              },
              child: Container( 
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Material( 
                  elevation: 2.0,
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 25, 25, 25),
                  child: Container( 
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    decoration: const BoxDecoration( 
                      color: Color.fromARGB(255, 25, 25, 25),
                    ),
                    child: Row( 
                      children: [ 
                        const Icon(Icons.logout, color: Colors.white,),
                        const SizedBox(width: 20.0,),
                        Column( 
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("LogOut", style: TextStyles.SamiBoldTextFeildStyle(false),),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}