// ignore_for_file: non_constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_application/Widgets/TextStyles.dart';
import 'package:food_delivery_application/Widgets/FoodCategory.dart';
import 'package:food_delivery_application/service/database.dart';
import 'package:food_delivery_application/pages/details.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
// variables
  bool pizza = true, iceCrem = false, burger = false, salad = false;

  Stream? fooditemStream;

  ontheLoad() async {
    fooditemStream = await DatabaseMethods().getFoodItem("Pizza");
    setState(() {});
  }

  @override
  void initState() {
    ontheLoad();
    super.initState();
  }

  Widget allHorizontalItems() {
    return StreamBuilder(stream: fooditemStream, builder: (context, AsyncSnapshot snapshot) {
      return snapshot.hasData? ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: snapshot.data.docs.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
        DocumentSnapshot food = snapshot.data.docs[index];
        return Row(
          children : [ GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => Details(ImageUrl: food["Image"], FoodName: food["Name"], FoodDescription: food["Detail"], FoodPrice: food["Price"])));
            },
            child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              margin: const EdgeInsets.all(4),
              padding: const EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect( 
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      food["Image"],
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        food["Name"],
                        style: TextStyles.SamiBoldTextFeildStyle(true),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: 150,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        food["Detail"],
                        style: TextStyles.LightTextFeildStyle(true),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${Texts.rupeeText()}  ${food["Price"]}',
                    style: TextStyles.SamiBoldTextFeildStyle(true),
                  ),
                ],
              ),
            )),
          ), 
          const SizedBox(width: 15,)
          ]
        );
      }) 
      : 
      const Center(
        child: CircularProgressIndicator(),
      );
    });
  }

  Widget allVerticalItems() {
    return StreamBuilder(stream: fooditemStream, builder: (context, AsyncSnapshot snapshot) {
      return snapshot.hasData? ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: snapshot.data.docs.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
        DocumentSnapshot food = snapshot.data.docs[index];
        return Column(
          children : [ GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => Details(ImageUrl: food["Image"], FoodName: food["Name"], FoodDescription: food["Detail"], FoodPrice: food["Price"])));
            },
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        food["Image"],
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 20.0,),
                    SizedBox(
                      height: 120,
                      width: MediaQuery.of(context).size.width / 2.1,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20,),
                            Text(
                              food["Name"],
                              style: const TextStyle(fontWeight: FontWeight.bold), // Example style
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              food["Detail"],
                              style: const TextStyle(fontWeight: FontWeight.normal), // Example style
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                            '${Texts.rupeeText()}  ${food["Price"]}',
                              style: TextStyles.SamiBoldTextFeildStyle(true),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ), 
          const SizedBox(height: 15,)
          ]
        );
      }) 
      : 
      const Center(
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        margin: const EdgeInsets.only(top: 50, left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container( 
              margin: const EdgeInsets.only(right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Hello Himesh,",
                      style: TextStyles.BoldTextFeildStyle(false)),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text("Tasty Foods", style: TextStyles.HeaderTextFeildStyle(false)),
            Text("Find and get great food",
                style: TextStyles.LightTextFeildStyle(false)),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: FoodCatagoryMenu(), // menu of food category using bottom widget
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SizedBox( 
                height: MediaQuery.of(context).size.height / 1.55,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView( 
                child: Column( 
                  children: [ 
                    Container(
                      height: 250,
                      child: allHorizontalItems()
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2.9,
                      child: allVerticalItems(),
                    )
                  ],
                ),
              ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // menu of food category
  Widget FoodCatagoryMenu() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: ()  async{
            pizza = true;
            iceCrem = false;
            burger = false;
            salad = false;
            fooditemStream = await DatabaseMethods().getFoodItem("Pizza");
            setState(() {});
          },
          child: FoodCategory.Menu("images/pizza.png" ,
              pizza
              ),
        ),
        GestureDetector(
          onTap: () async{
            pizza = false;
            iceCrem = true;
            burger = false;
            salad = false;
            fooditemStream = await DatabaseMethods().getFoodItem("Ice-cream");
            setState(() {});
          },
          child: FoodCategory.Menu("images/ice-cream.png" ,
              iceCrem 
              ),
        ),
        GestureDetector(
          onTap: () async{
            pizza = false;
            iceCrem = false;
            burger = true;
            salad = false;
            fooditemStream = await DatabaseMethods().getFoodItem("Burger");
            setState(() {});
          },
          child: FoodCategory.Menu("images/burger.png",
              burger
              ), 
        ),
        GestureDetector(
          onTap: () async{
            pizza = false;
            iceCrem = false;
            burger = false;
            salad = true;
            fooditemStream = await DatabaseMethods().getFoodItem("Salad");
            setState(() {});
          },
          child: FoodCategory.Menu("images/salad.png" ,
            salad 
          ), 
        ),
      ],
    );
  }
}

// Vertical