import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_application/service/database.dart';
import 'package:food_delivery_application/Widgets/TextStyles.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  final _formkey = GlobalKey<FormState>();
  final List<String> fooditems = ['Pizza', 'Ice-cream', 'Burger', 'Salad'];
  String? value;
  String name = "", detail = "";
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _pricecontroller = TextEditingController();
  final TextEditingController _detailcontroller = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? selectedImage = null;

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);

    selectedImage = File(image!.path);
    setState(() {});
  }

  uploadItem() async {
    print("add button hitted");
    if (selectedImage != null &&
      _nameController.text != "" &&
      _pricecontroller.text != "" &&
      _detailcontroller.text != "") {
      String addId = randomAlphaNumeric(10);
      Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child("blogImages").child(addId);
      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);
      var downloadUrl = await (await task).ref.getDownloadURL();
      Map<String, dynamic> addItem = {
        "Image": downloadUrl,
        "Name": _nameController.text,
        "Price": _pricecontroller.text,
        "Detail": _detailcontroller.text
      };
      await DatabaseMethods().addFoodItem(addItem, value!).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.black,
            content: Text(
              "Food added Successfully",
              style: TextStyle(fontSize: 18.0),
            )
          )
        );
      });
      selectedImage = null;
      _nameController.text = "";
      _detailcontroller.text = "";
      _pricecontroller.text = "";
      value = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.white,
            )),
        centerTitle: true,
        title: Text(
          "Add Item",
          style: TextStyles.HeaderTextFeildStyle(false),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Upload the Item Picture",
                style: TextStyles.LightTextFeildStyle(false),
              ),
              const SizedBox(
                height: 20.0,
              ),
              selectedImage == null
                  ? GestureDetector(
                      onTap: () {
                        print("Get image from");
                        //have tap krto
                        getImage();
                      },
                      child: Center(
                        child: Material(
                          color: Colors.black,
                          elevation: 4.0,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white, width: 1.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Material(
                        elevation: 4.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 1.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(
                              selectedImage!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 30.0,
              ),
              Text(
                "Item Name",
                style: TextStyles.LightTextFeildStyle(false),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: _nameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder( // Customize focused border
                      borderSide: const BorderSide(color: Colors.white), // Set focused border color to white
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "Enter Item Name",
                    hintStyle: TextStyles.LightTextFeildStyle(false),
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Text(
                "Item Price",
                style: TextStyles.LightTextFeildStyle(false),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: _pricecontroller,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder( // Customize focused border
                      borderSide: const BorderSide(color: Colors.white), // Set focused border color to white
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "Enter Item Price",
                    hintStyle: TextStyles.LightTextFeildStyle(false),
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Text(
                "Item Detail",
                style: TextStyles.SamiBoldTextFeildStyle(false),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  maxLines: 6,
                  controller: _detailcontroller,
                  style: const TextStyle(color: Colors.white), // Setting text color to white
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white), // Setting border color to white
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white), // Setting focused border color to white
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "Enter Item Detail",
                    hintStyle: TextStyles.LightTextFeildStyle(false),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                "Select Category",
                style: TextStyles.SamiBoldTextFeildStyle(false),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.white, width: 1.5),
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                  items: fooditems
                      .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyles.SamiBoldTextFeildStyle(false),
                          )))
                      .toList(),
                  onChanged: ((value) => setState(() {
                        this.value = value;
                      })),
                  dropdownColor: Colors.black,
                  hint: Text("Select Category", style: TextStyles.LightTextFeildStyle(false),),
                  iconSize: 36,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                  value: value,
                )),
              ),
              const SizedBox(
                height: 30.0,
              ),
              GestureDetector(
                onTap: (){
                  uploadItem();
                },
                child: Center(
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Add",
                          style: TextStyles.ButtonTextFeildStyle(true),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}