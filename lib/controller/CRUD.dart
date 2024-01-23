import 'package:cloud_firestore/cloud_firestore.dart';

class CRUDService {
// add new contacts to firestore
  Future addNewContacts(
    String name,
    dynamic phone, // Change type to dynamic
    String job,
  ) async {
    Map<String, dynamic> data = {
      "name": name,
      "phone": phone,
      "job": job,
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

    // a filter to perform search
    if (searchQuery != null && searchQuery.isNotEmpty) {
      String searchEnd = searchQuery + "\uf8ff";
      contactsQuery = contactsQuery.where("name",
          isGreaterThanOrEqualTo: searchQuery, isLessThan: searchEnd);
    }

    var contacts = contactsQuery.snapshots();
    yield* contacts;
  }

  // add multiple contacts to firestore
  Future addMultipleContacts(List<Map<String, dynamic>> contacts) async {
    try {
      for (var contact in contacts) {
        await FirebaseFirestore.instance.collection("users").add(contact);
      }

      print("Multiple Documents Added");
    } catch (e) {
      print(e.toString());
    }
  }

  // update a contact
  Future updateContact(
    String name,
    dynamic phone, // Change type to dynamic
    String docID,
    String job,
  ) async {
    Map<String, dynamic> data = {
      "name": name,
      "phone": phone,
      "job": job,
    };
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(docID)
          .update(data);
      print("Document Updated");
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
