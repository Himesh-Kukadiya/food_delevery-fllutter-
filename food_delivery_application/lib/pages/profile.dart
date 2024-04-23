

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:food_delivery_application/Widgets/TextStyles.dart';
import 'package:food_delivery_application/service/shared_pref.dart';
import 'package:image_picker/image_picker.dart';
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? Name = "himesh Kukadiya";
  String? Email = "himesh@gmail.com";
  String? Profile = "boy.png";

  final ImagePicker _picker = ImagePicker();
  File? selectedImage = null;
  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    uploadItem();
    setState(() {});
  }

  uploadItem() async {
  if (selectedImage != null) {
    String addId = randomAlphaNumeric(10);
    Reference firebaseStorageRef =
      FirebaseStorage.instance.ref().child("blogImages").child(addId);
    UploadTask uploadTask = firebaseStorageRef.putFile(selectedImage!);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    // Get download URL
    var downloadUrl = await taskSnapshot.ref.getDownloadURL();
    await SharedPreferenceHelper().saveUserProfile(downloadUrl);
    setState((){});
  }
}


  getthesharedpref() async{
    Profile = await SharedPreferenceHelper().getUserProfile();
    Name = await SharedPreferenceHelper().getUserName();
    Email = await SharedPreferenceHelper().getUserEmail();
    setState(() {});
  }
  

  onthisload() async{ 
    await getthesharedpref();
    setState(() {
    });
  }

  @override
  void initState() {
    onthisload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: Colors.black87,
      body: Email == null? const Center(child: CircularProgressIndicator()) : SingleChildScrollView(
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
                        child: selectedImage == null ? 
                            Profile == null ? GestureDetector(
                              onTap : () {
                                getImage();
                              },  
                              child: Image.asset('images/boy.png', height: 120, width: 120, fit: BoxFit.cover,)
                            ) : 
                            GestureDetector(
                            onTap : () {
                              getImage();
                            },  
                            child: Image.network(Profile!, height: 120, width: 120, fit: BoxFit.cover,)
                          )
                          : 
                          Image.file(selectedImage!, height: 120, width: 120, fit: BoxFit.cover,),
                      ),
                    ),
                  ),
                ),
                Padding(padding: const EdgeInsets.only(top: 90.0), child: Row( 
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [ 
                    Text(Name.toString(), style: TextStyles.SamiBoldTextFeildStyle(true),)
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
                          Text(Name.toString(), style: TextStyles.SamiBoldTextFeildStyle(false),),
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 120,
                            child: Text(Email.toString(), style: TextStyles.SamiBoldTextFeildStyle(false),)
                          ),
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
                      const Icon(Icons.description, color: Colors.white,),
                      const SizedBox(width: 20.0,),
                      Column( 
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Terms & Condition", style: TextStyles.SamiBoldTextFeildStyle(false),),
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
                      const Icon(Icons.delete, color: Colors.white,),
                      const SizedBox(width: 20.0,),
                      Column( 
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Delete Account", style: TextStyles.SamiBoldTextFeildStyle(false),),
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
          ],
        ),
      ),
    );
  }
}