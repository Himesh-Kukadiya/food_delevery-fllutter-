import 'dart:async';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_application/Widgets/TextStyles.dart';
import 'package:food_delivery_application/service/database.dart';
import 'package:food_delivery_application/service/shared_pref.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  String? Id, Wallet;
  int total = 0, amount2 = 0;

  Stream? foodStream;

  void startTimer() {
    Timer(const Duration(seconds: 3), () {
      amount2 = total;
      setState(() {});
    });
  }

  getthesharedpref() async {
    Id = await SharedPreferenceHelper().getUserId();
    Wallet = await SharedPreferenceHelper().getUserWallet();
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    foodStream = await DatabaseMethods().getFoodItemToCart(Id!);
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    startTimer();
    super.initState();
  }

  Widget foodCart() {
    return StreamBuilder(
      stream: foodStream,
      builder: (context, AsyncSnapshot snapshot) {
      return snapshot.hasData
      ? ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: snapshot.data.docs.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          DocumentSnapshot ds = snapshot.data.docs[index];
          total = total + int.parse(ds["Total"]);
          return Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10)
              ),
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [ 
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(30)),
                        child: Center(child: Text(ds["Quantity"])),
                      ),
                      const SizedBox(height: 10,),
                      GestureDetector(
                        onTap: () async{
                          // print(ds.id);
                          await DatabaseMethods().removeFoodItemsFromCart(Id!, ds.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Item Removed from Cart",
                                style: TextStyles.SamiBoldTextFeildStyle(false),
                              ),
                              backgroundColor: const Color.fromARGB(255, 28, 28, 28),
                            ),
                          );
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(30)),
                          child: const Center(child: Icon(Icons.delete)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20.0,),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.network(
                      ds["Image"],
                      height: 90,
                      width: 90,
                      fit: BoxFit.cover,
                    )
                  ),
                  const SizedBox(width: 20.0,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Text(ds.id, style: TextStyles.SamiBoldTextFeildStyle(true),),
                      Text(
                        ds["Name"],
                        style: TextStyles.SamiBoldTextFeildStyle(true),
                      ),
                      Text(
                        "${Texts.rupeeText()} ${ds['Total']}",
                        style: TextStyles.SamiBoldTextFeildStyle(true),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      })
    : const Center(child: CircularProgressIndicator(),);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 70,
            ),
            Material(
              elevation: 2.0,
              child: Container(
                color: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Center(
                    child: Text(
                  "Food Cart",
                  style: TextStyles.HeaderTextFeildStyle(false),
                )),
              ),
            ),
            const Divider(),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: foodCart()
            ),
            const Spacer(),
            const Divider(),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Price",
                    style: TextStyles.BoldTextFeildStyle(false),
                  ),
                  Text(
                    "${Texts.rupeeText()} $total",
                    style: TextStyles.SamiBoldTextFeildStyle(false),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () async {
                if(double.parse(Wallet!) >= amount2) {
                  String amt = (double.parse(Wallet!) - amount2).toString();
                  await DatabaseMethods().UpdateUserWallet(Id!, amt);
                  await SharedPreferenceHelper().saveUserWallet(amt);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Order Placed Successfully!",
                        style: TextStyles.SamiBoldTextFeildStyle(false),
                      ),
                      backgroundColor: const Color.fromARGB(255, 28, 28, 28),
                    ),
                  );
                }
                else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Please Add Money!",
                        style: TextStyles.SamiBoldTextFeildStyle(false),
                      ),
                      backgroundColor: Colors.orange,
                    ),
                  );
                }
                // await DatabaseMethods().removeFoodItemsFromCart(Id!);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                child: Center(
                  child: Text(
                    "Check Out",
                    style: TextStyles.ButtonTextFeildStyle(true),
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
