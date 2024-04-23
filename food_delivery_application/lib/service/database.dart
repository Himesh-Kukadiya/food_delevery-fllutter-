import "package:cloud_firestore/cloud_firestore.dart";

class DatabaseMethods {

  Future addUser (Map<String, dynamic> useInfoMap, String id) async {
    return await FirebaseFirestore.instance
      .collection("User")
      .doc(id)
      .set(useInfoMap);
  }

  Future<void> removeUserData(String userId) async {
    DocumentReference userDocRef = FirebaseFirestore.instance
      .collection("User")
      .doc(userId);
    await userDocRef.delete();
  }


  UpdateUserWallet(String id, String amount) async {
    return await FirebaseFirestore.instance
    .collection("User")
    .doc(id)
    .update({"Wallet": amount});
  }

  Future addFoodItem (Map<String, dynamic> foodInfoMap, String name) async {
    return await FirebaseFirestore.instance
      .collection(name)
      .add(foodInfoMap);
  }

  Future addFoodItemToCart (Map<String, dynamic> foodInfoMap, String Id) async {
    return await FirebaseFirestore.instance
      .collection("User")
      .doc(Id).collection("Cart")
      .add(foodInfoMap);
  }

  Future<Stream<QuerySnapshot>> getFoodItem(String name) async {
    return await FirebaseFirestore.instance
      .collection(name)
      .snapshots();
  }

  Future<Stream<QuerySnapshot>> getFoodItemToCart(String Id) async {
    return await FirebaseFirestore.instance
      .collection("User")
      .doc(Id).collection("Cart")
      .snapshots();
  }

  Future<void> removeFoodItemsFromCart(String userId, String CartId) async {
    CollectionReference cartCollection = FirebaseFirestore.instance
      .collection("User")
      .doc(userId)
      .collection("Cart");
    DocumentReference cartDocument = cartCollection.doc(CartId);
    await cartDocument.delete();
  }
}