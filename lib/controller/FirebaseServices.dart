// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:phonetest/Screen/update.dart';
// import 'package:phonetest/controller/CRUD.dart';
// import 'package:phonetest/controller/auth.dart';
// import 'package:url_launcher/url_launcher.dart';

// class AdminHomePage extends StatefulWidget {
//   const AdminHomePage({Key? key});

//   @override
//   State<AdminHomePage> createState() => _AdminHomePageState();
// }

// class _AdminHomePageState extends State<AdminHomePage> {
//   late Stream<QuerySnapshot> _stream;
//   TextEditingController _searchController = TextEditingController();
//   FocusNode _searchFocusNode = FocusNode();
//   FirebaseService _firebaseService =
//       FirebaseService(); // Added FirebaseService instance

//   @override
//   void initState() {
//     _stream = CRUDService().getContacts();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _searchFocusNode.dispose();
//     super.dispose();
//   }

//   // to call the contact using url launcher
//   callUser(String phone) async {
//     String url = "tel:$phone";
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw "Could not launch $url ";
//     }
//   }

//   // search Function to perform search
//   searchContacts(String search) {
//     _stream = CRUDService().getContacts(searchQuery: search);
//   }

//   // Function to add contact to Firebase
//   addContactToFirebase(String name, String phone, String email) {
//     _firebaseService.addContact(name, phone, email);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Contacts"),
//         // search box
//         bottom: PreferredSize(
//           child: Container(
//             padding: EdgeInsets.symmetric(vertical: 8),
//             child: SizedBox(
//               width: MediaQuery.of(context).size.width * .9,
//               child: TextFormField(
//                 onChanged: (value) {
//                   searchContacts(value);
//                   setState(() {});
//                 },
//                 focusNode: _searchFocusNode,
//                 controller: _searchController,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   label: Text("Search"),
//                   prefixIcon: Icon(Icons.search),
//                   suffixIcon: _searchController.text.isNotEmpty
//                       ? IconButton(
//                           onPressed: () {
//                             _searchController.clear();
//                             _searchFocusNode.unfocus();
//                             _stream = CRUDService().getContacts();
//                             setState(() {});
//                           },
//                           icon: Icon(Icons.close),
//                         )
//                       : null,
//                 ),
//               ),
//             ),
//           ),
//           preferredSize: Size(MediaQuery.of(context).size.width * 8, 80),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.pushNamed(context, "/add");
//         },
//         child: Icon(Icons.person_add),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           children: [
//             DrawerHeader(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CircleAvatar(
//                     maxRadius: 32,
//                     child: Text(
//                       FirebaseAuth.instance.currentUser!.email!
//                           .toString()[0]
//                           .toUpperCase(),
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     FirebaseAuth.instance.currentUser!.email.toString(),
//                   ),
//                 ],
//               ),
//             ),
//             ListTile(
//               onTap: () {
//                 AuthService().logout();
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text("Logged Out")),
//                 );
//                 Navigator.pushReplacementNamed(context, "/login");
//               },
//               leading: Icon(Icons.logout_outlined),
//               title: Text("Logout"),
//             ),
//           ],
//         ),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _stream,
//         builder: (
//           BuildContext context,
//           AsyncSnapshot<QuerySnapshot> snapshot,
//         ) {
//           if (snapshot.hasError) {
//             return Text("Something Went Wrong");
//           }
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: Text("Loading"),
//             );
//           }
//           return snapshot.data!.docs.length == 0
//               ? Center(
//                   child: Text("No Contacts Found ..."),
//                 )
//               : ListView(
//                   children: snapshot.data!.docs
//                       .map((DocumentSnapshot document) {
//                         Map<String, dynamic> data =
//                             document.data()! as Map<String, dynamic>;
//                         return ListTile(
//                           onTap: () => Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => UpdateContact(
//                                 name: data["name"],
//                                 phone: data["phone"],
//                                 email: data["email"],
//                                 docID: document.id,
//                               ),
//                             ),
//                           ),
//                           leading: CircleAvatar(child: Text(data["name"][0])),
//                           title: Text(data["name"]),
//                           subtitle: Text(data["phone"]),
//                           trailing: IconButton(
//                             icon: Icon(Icons.call),
//                             onPressed: () {
//                               setState(() {
//                                 callUser(data["phone"]);
//                               });
//                               callUser(data["phone"]);
//                             },
//                           ),
//                         );
//                       })
//                       .toList()
//                       .cast(),
//                 );
//         },
//       ),
//     );
//   }
// }

// class FirebaseService {
//   final CollectionReference contactsCollection =
//       FirebaseFirestore.instance.collection('contacts');

//   Future<void> addContact(String name, String phone, String email) async {
//     await contactsCollection.add({
//       'name': name,
//       'phone': phone,
//       'email': email,
//     });
//   }
// }
