// ignore_for_file: non_constant_identifier_names


import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:food_delivery_application/Widgets/TextStyles.dart';
import 'package:food_delivery_application/service/database.dart';
import 'package:food_delivery_application/service/shared_pref.dart';

class Details extends StatefulWidget {
  final String ImageUrl;
  final String FoodName;
  final String FoodDescription;
  final String FoodPrice;
  const Details({super.key, required this.ImageUrl, required this.FoodName, required this.FoodDescription, required this.FoodPrice});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String? Id;
  int quantity = 1;
  int totalAmount = 0;

  handleTotalAmount(amount) {
    totalAmount = quantity * int.parse(widget.FoodPrice);
    setState(() {});
  }
  getthesharedpref() async {
    Id = await SharedPreferenceHelper().getUserId();
    setState(() {});
  }
  ontheload() async {
    await getthesharedpref();
    setState(() {});
  }
  @override
  void initState() {
    totalAmount = int.parse(widget.FoodPrice);
    ontheload();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Id == null ? 
      const Center(
        child: CircularProgressIndicator(),
      ) 
      :
      Container(
        margin: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material( 
              elevation: 10.0,
              borderRadius: BorderRadius.circular(5),
              child: Padding( 
                padding: const EdgeInsets.only(top: 5, bottom: 5, left: 8, right: 8),
                child: GestureDetector( 
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back, color: Colors.black87,),
                ),
              ),
            ),
            Image.network(widget.ImageUrl, width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 15,),
            Row( 
              children: [ 
                Column( 
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children: [ 
                    Text(widget.FoodName, style: TextStyles.SamiBoldTextFeildStyle(false),),
                    SizedBox( width: MediaQuery.of(context).size.width / 2, child: Text(widget.FoodDescription, style: TextStyles.LightTextFeildStyle(false)))
                  ],
                ),
                const Spacer(),
                GestureDetector( 
                  onTap: () {
                    if(quantity > 1) 
                      --quantity;
                      handleTotalAmount(totalAmount);
                    setState(() {
                    });
                  },
                  child: Container( 
                    decoration: BoxDecoration( 
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon( Icons.remove, color: Colors.black,),
                  ),
                ),
                const SizedBox(width: 20,),
                Text(quantity.toString(), style: TextStyles.SamiBoldTextFeildStyle(false),),
                const SizedBox(width: 20,),
                GestureDetector( 
                  onTap: () {
                    ++quantity;
                    handleTotalAmount(totalAmount);
                    setState(() {
                    });
                  },
                  child: Container( 
                    decoration: BoxDecoration( 
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon( Icons.add, color: Colors.black,),
                  ),
                ),
              ],
            ),
            const SizedBox( height: 20,),
            Text("Crisp lettuce, sweet tomatoes, crunchy carrots, ripe avocados, zesty dressing, and sprinkled with feta, salads offer a deliciously refreshing, healthy meal option.", style: TextStyles.LightTextFeildStyle(false), maxLines: 3,),
            const SizedBox(height: 20,),
            Row( 
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [ 
                Text("Delivery Time", style: TextStyles.SamiBoldTextFeildStyle(false)),
                Row( 
                  children: [ 
                    const Icon(Icons.alarm_outlined, color: Colors.white,),
                    const SizedBox(width: 10,),
                    Text("30 min", style: TextStyles.SamiBoldTextFeildStyle(false))
                  ],
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total Price ", style: TextStyles.SamiBoldTextFeildStyle(false),),
                      Text(Texts.rupeeText() + (totalAmount).toString(), style: TextStyles.SamiBoldTextFeildStyle(false),),
                    ]
                  ),
                  GestureDetector(
                    onTap: () async {
                      Map<String, dynamic> addFoodtoCart = {
                        "Name": widget.FoodName,
                        "Quantity": quantity.toString(),
                        "Total": totalAmount.toString(),
                        "Image": widget.ImageUrl,
                        "Price": widget.FoodPrice
                      };
                      await DatabaseMethods().addFoodItemToCart(addFoodtoCart, Id!);
                      ScaffoldMessenger.of(context).showSnackBar((SnackBar(content: Text("Food Added To The Cart", style: TextStyles.SamiBoldTextFeildStyle(false),), backgroundColor: const Color.fromARGB(255, 28, 28, 28),)));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Add to cart", style: TextStyles.ButtonTextFeildStyle(true),),
                          const SizedBox(width: 30,),
                          Container( 
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: Colors.white38,
                              borderRadius: BorderRadius.circular(8)
                            ),
                            child: const Icon( Icons.shopping_cart_outlined, color: Colors.black,),
                          )
                        ],
                      )
                    )
                  ),
                ]
              )
            )
          ],
        )
      )
    );
  }
}