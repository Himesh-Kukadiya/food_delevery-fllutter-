import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:food_delivery_application/Widgets/TextStyles.dart';
import 'package:food_delivery_application/service/database.dart';
import 'package:food_delivery_application/service/shared_pref.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  String? myWallet, Id;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String upi = "@oksbi";
  final TextEditingController _upiIdController = TextEditingController();

  getthesharedpref() async {
    myWallet = await SharedPreferenceHelper().getUserWallet();
    Id = await SharedPreferenceHelper().getUserId();
    setState(() {});
  }
  @override
  void initState() {
    _upiIdController.text = "@oksbi";
    getthesharedpref();
    myWallet == null ? myWallet = "0" : myWallet = myWallet;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 70),
            Material(
              elevation: 2.0,
              child: Container(
                color: Colors.black87,
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Center(
                    child: Text(
                      "Wallet",
                      style: TextStyles.HeaderTextFeildStyle(false),
                    )),
              ),
            ),
            const SizedBox(height: 30.0),
            Container(
              color: const Color.fromARGB(255, 25, 25, 25),
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Image.asset("images/wallet.png", height: 60, width: 60, fit: BoxFit.cover),
                  const SizedBox(width: 40.0),
                  Column(
                    children: [
                      Text("Your Wallet", style: TextStyles.LightTextFeildStyle(false)),
                      const SizedBox(height: 5),
                      Text("${Texts.rupeeText()} $myWallet", style: TextStyles.BoldTextFeildStyle(false)),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 40.0),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("Add Money", style: TextStyles.SamiBoldTextFeildStyle(false)),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildPaymentCard(context, 100),
                buildPaymentCard(context, 500),
                buildPaymentCard(context, 1000),
                buildPaymentCard(context, 2000),
              ],
            ),
            const SizedBox(height: 60.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Center(
                child: Text(
                  "Add Money",
                  style: TextStyles.BoldTextFeildStyle(true),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildPaymentCard(BuildContext context, int amount) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
    decoration: BoxDecoration(border: Border.all(color: Colors.white54)),
    child: GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return Form(
              key: _formKey,
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                        top: MediaQuery.of(context).viewInsets.top + 20,
                        left: MediaQuery.of(context).viewInsets.left + 20,
                        right: MediaQuery.of(context).viewInsets.right + 20,
                      ),
                      width: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Patelsir Payment", style: TextStyles.HeaderTextFeildStyle(true)),
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                          Material(
                            elevation: 2.0,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _upiIdController,
                            decoration: InputDecoration(
                              labelText: 'Enter UPI ID',
                              labelStyle: TextStyles.SamiBoldTextFeildStyle(true),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              prefixIcon: const Icon(Icons.payment_rounded),
                            ),
                            validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your UPI ID';
                                }
                                List<String> parts = value.split('@ok');
                                List<String> allowedBankNames = ['sbi', 'boi', 'pnb', 'cb']; 
                                if (parts.length != 2 || !allowedBankNames.contains(parts[1].toLowerCase())) {
                                  return 'Enter Valid UPI ID';
                                }
                                return null; // Return null if the input is valid
                              },
                          ),
                          const SizedBox(height: 20),
                          Text("Easy & Secure Payment by Patelsir Payment", style: TextStyles.LightTextFeildStyle(true)),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${Texts.rupeeText()} $amount",
                                style: TextStyles.SamiBoldTextFeildStyle(true),
                              ),
                              GestureDetector(
                                onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  await SharedPreferenceHelper().saveUserWallet((double.parse(myWallet!) + amount).toString());
                                  await DatabaseMethods().UpdateUserWallet(Id!, (double.parse(myWallet!) + amount).toString());
                                  Navigator.pop(context);
                                  Navigator.of(context).popUntil((route) => route.isFirst);
                                  // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Wallet()));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                            size: 80,
                                          ),
                                          const SizedBox(height: 20),
                                          Text(
                                            "Payment Successful",
                                            style: TextStyles.SamiBoldTextFeildStyle(true),
                                          ),
                                        ],
                                      ),
                                      backgroundColor: Colors.white,
                                    ),
                                  );
                                }
                              },
                                child: Material(
                                  elevation: 2.0,
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container( 
                                    decoration: BoxDecoration( 
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black,
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    width: MediaQuery.of(context).size.width / 3,
                                    child: Center(child: Text("Process", style: TextStyles.ButtonTextFeildStyle(false),)),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
      child: Text("${Texts.rupeeText()} $amount", style: TextStyles.SamiBoldTextFeildStyle(false)),
    ),
  );
}
// import 'dart:async';

void showPaymentSuccessModal(BuildContext context) {
  showModalBottomSheet(
    
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          top: MediaQuery.of(context).viewInsets.top + 20,
          left: MediaQuery.of(context).viewInsets.left + 20,
          right: MediaQuery.of(context).viewInsets.right + 20,
        ),
        width: double.infinity,
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 80,
            ),
            SizedBox(height: 20),
            Text(
              "Payment Successful",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    },
  );
}

}