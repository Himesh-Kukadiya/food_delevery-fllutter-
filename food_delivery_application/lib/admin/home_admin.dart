import 'package:flutter/material.dart';
import 'package:food_delivery_application/Widgets/TextStyles.dart';
import 'package:food_delivery_application/admin/add_food.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Container(
        margin: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
        child: Column(
          children: [
            Center(child: Text("Home Admin", style: TextStyles.HeaderTextFeildStyle(false),),),
            const SizedBox(height: 50.0,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const AddFood()));
              },
              child: Material(
                elevation: 10.0,
                borderRadius: BorderRadius.circular(10),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      
                    ),
                    child: Row(children: [
                      Padding(padding: const EdgeInsets.all(6.0),
                      child: Image.asset("images/food.jpg", height: 100, width: 100, fit: BoxFit.cover,),),
                  const SizedBox(width: 30.0,) ,
                  Text("Add Food Items", style: TextStyles.SamiBoldTextFeildStyle(true)) ],),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}