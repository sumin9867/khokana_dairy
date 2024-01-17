import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CRUDService {
// add new contacts to firestore
  Future addNewContacts(String name, String phone, String email, String job,
      String kuna, String tole) async {
    Map<String, dynamic> data = {
      "name": name,
      "email": email,
      "phone": phone,
      "job": job,
      "kuna": kuna,
      "tole": tole
    };
    try {
      await FirebaseFirestore.instance.collection("users").add(data);
      print("Document Added");
    } catch (e) {
      print(e.toString());
    }
  }

  // read documents inside firestore
  Stream<QuerySnapshot> getContacts({String? searchQuery}) async* {
    var contactsQuery =
        FirebaseFirestore.instance.collection("users").orderBy("name");

    // a filter to perfom search
    if (searchQuery != null && searchQuery.isNotEmpty) {
      String searchEnd = searchQuery + "\uf8ff";
      contactsQuery = contactsQuery.where("name",
          isGreaterThanOrEqualTo: searchQuery, isLessThan: searchEnd);
    }

    var contacts = contactsQuery.snapshots();
    yield* contacts;
  }

  // update a contact
  Future updateContact(String name, String phone, String email, String docID,
      String job, String kuna, String tole) async {
    Map<String, dynamic> data = {
      "name": name,
      "email": email,
      "phone": phone,
      "job": job,
      "kuna": kuna,
      "tole": tole
    };
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(docID)
          .update(data);
      print("Document Upated");
    } catch (e) {
      print(e.toString());
    }
  }

  // delete contact from firestore
  Future deleteContact(String docID) async {
    try {
      await FirebaseFirestore.instance.collection("users").doc(docID).delete();
      print("Contact Deleted");
    } catch (e) {
      print(e.toString());
    }
  }
}
