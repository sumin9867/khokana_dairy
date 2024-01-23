import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:phonetest/Screen/update.dart';
import 'package:phonetest/controller/CRUD.dart';
import 'package:phonetest/controller/auth.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  late Stream<QuerySnapshot> _stream;
  TextEditingController _searchController = TextEditingController();
  FocusNode _searchfocusNode = FocusNode();
  static bool contactsAdded = false;

  @override
  void initState() {
    super.initState();

    // Check if contacts have already been added
    if (!contactsAdded) {
      // Contacts haven't been added yet, so add them
      addMultipleContactsOnInit();
      // Set contacts added status to true
      contactsAdded = true;
    }

    _stream = CRUDService().getContacts();
  }

  @override
  void dispose() {
    _searchfocusNode.dispose();
    super.dispose();
  }

  // to call the contact using url launcher
  callUser(String phone) async {
    try {
      bool? res = await FlutterPhoneDirectCaller.callNumber(phone);
      if (res != null && res) {
        print("Phone call successful");
      } else {
        throw "Could not make a phone call to $phone";
      }
    } catch (e) {
      print("Error making a phone call: $e");
    }
  }

  // search Function to perform search

  Future<void> addMultipleContactsOnInit() async {
    List<Map<String, dynamic>> contacts = [
      // Add more contacts as needed
    ];

    await CRUDService().addMultipleContacts(contacts);
  }

  searchContacts(String search) {
    _stream =
        CRUDService().getContacts(searchQuery: search).asBroadcastStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
        // search box
        bottom: PreferredSize(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * .9,
                  child: TextFormField(
                    onChanged: (value) {
                      searchContacts(value);
                      setState(() {});
                    },
                    focusNode: _searchfocusNode,
                    controller: _searchController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        label: Text("Search"),
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  _searchController.clear();
                                  _searchfocusNode.unfocus();
                                  _stream = CRUDService().getContacts();
                                  setState(() {});
                                },
                                icon: Icon(Icons.close),
                              )
                            : null),
                  )),
            ),
            preferredSize: Size(MediaQuery.of(context).size.width * 8, 80)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/add");
        },
        child: Icon(Icons.person_add),
      ),
      drawer: Drawer(
          child: ListView(
        children: [
          ListTile(
            onTap: () {
              AuthService().logout();
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Logged Out")));
              Navigator.pushReplacementNamed(context, "/login");
            },
            leading: Icon(Icons.logout_outlined),
            title: Text("Logout"),
          )
        ],
      )),
      body: StreamBuilder<QuerySnapshot>(
          stream: _stream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something Went Wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text("Loading"),
              );
            }
            return snapshot.data!.docs.length == 0
                ? Center(
                    child: Text("No Contacts Found ..."),
                  )
                : ListView(
                    children: snapshot.data!.docs
                        .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;

                          return ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            leading: CircleAvatar(
                                child: CircleAvatar(
                              child: Text(data["name"][0],
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            )),
                            title: Text(
                              data["name"],
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      data["phone"],
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: const Color.fromARGB(
                                              255, 69, 69, 69)),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Text(
                                  data["job"],
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey[600]),
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.call),
                              onPressed: () {
                                setState(() {
                                  callUser(data["phone"]);
                                });
                                callUser(data["phone"]);
                              },
                            ),
                            onLongPress: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateContact(
                                        name: data["name"],
                                        phone: data["phone"],
                                        job: data["job"],
                                        docID: document.id))),
                          );
                        })
                        .toList()
                        .cast(),
                  );
          }),
    );
  }
}
