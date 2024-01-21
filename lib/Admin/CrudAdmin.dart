import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    String url = "tel:$phone";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw "Could not launch $url ";
    }
  }

  // search Function to perform search

  Future<void> addMultipleContactsOnInit() async {
    List<Map<String, dynamic>> contacts = [
      // {"name": "अष्टमान महर्जन", "phone": "९८४१४११३३३", "job": "नोकरी"},
      // {"name": "असन महर्जन", "phone": "९८४९२८६०७२", "job": "नोकरी"},
      // {"name": "असोज कुमार महर्जन", "phone": "९८६३५२३८२९", "job": "समाजसेवा"},
      // {
      //   "name": "अस्तेन्द्र कुमार महर्जन पुनवी दोबु",
      //   "phone": "९८१३७५४४६५",
      //   "job": "व्यवसाय"
      // },
      // {
      //   "name": "अस्मिता महर्जन (तग) बुंगमती",
      //   "phone": "९८४१७४२१८६",
      //   "job": "गृहिणी"
      // },
      // {
      //   "name": "अस्मिता महर्जन (मेछ्यो) सुन्धारा",
      //   "phone": "९८४३०९६६००",
      //   "job": "गृहिणी"
      // },
      // {"name": "आकाश थापा", "phone": "९८२३४५०७३६", "job": "विद्यार्थी"},
      // {"name": "आकृती थापा", "phone": "९८१३५२१०९५", "job": "विद्यार्थी"},
      // {
      //   "name": "आर्जिन महर्जन (बजीमनकु।",
      //   "phone": "९८४२५७१३४४",
      //   "job": "विद्यार्थी"
      // },
      // {
      //   "name": "आर्यन डंगोल (लाइटर) दुन्छे",
      //   "phone": "९८४०००४९०७",
      //   "job": "विद्यार्थी"
      // },
      // {
      //   "name": "आर्यन महर्जन (उराय)",
      //   "phone": "९८४९५११५४४",
      //   "job": "विद्यार्थी"
      // },
      // {
      //   "name": "आवाज महर्जन (व्याँ) व्यागलबु",
      //   "phone": "९८६४२७३२६७",
      //   "job": "म मार्केटिङ्ग"
      // },
      // {
      //   "name": "आशा रत्न डंगोल (माद्यो) दोबु",
      //   "phone": "९८४९१३४४९५",
      //   "job": "व्यवसाय"
      // },
      // {
      //   "name": "आशा राम महर्जन (व्याँ) व्यागलबु",
      //   "phone": "०१५५९२९१२",
      //   "job": "९८६०२१३७२८"
      // },
      // {
      //   "name": "डकर्मी",
      //   "phone": "डकर्मी",
      //   "job": "आशिष डंगोल (वामुख्वा) तखाछें",
      //   "phone": "९८२३१८२४६३",
      //   "job": "विद्यार्थी"
      // },
      // {
      //   "name": "आशिष महर्जन (ब्रम्हा) न्हयोबु",
      //   "phone": "९८४०००७०८",
      //   "job": "विद्यार्थी"
      // },
      // {
      //   "name": "आष्मा डंगोल (लाइटर) दुन्छे",
      //   "phone": "९८४३१७९५९५",
      //   "job": "नोकरी"
      // },
      // {
      //   "name": "इच्छा महर्जन (तग)",
      //   "phone": "खोकना दोवादा",
      //   "job": "इन्जिनियर"
      // },
      // {
      //   "name": "इन्द्र माया महर्जन (लोकमा) तन्चा",
      //   "phone": "९८०८६४४०७३",
      //   "job": "गृहिणी"
      // },
      // {
      //   "name": "इशवरी डंगोल (मैन) तन्चा",
      //   "phone": "९८६११३८३५४",
      //   "job": "गृहिणी"
      // },
      // {
      //   "name": "ईन्द्र बहादुर डंगोल (धेर) न्हयोबु",
      //   "phone": "९८६७०५३९७९",
      //   "job": "डकर्मी"
      // },

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
          DrawerHeader(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                maxRadius: 32,
                child: Text(FirebaseAuth.instance.currentUser!.email
                    .toString()[0]
                    .toUpperCase()),
              ),
              SizedBox(
                height: 10,
              ),
              Text(FirebaseAuth.instance.currentUser!.email.toString())
            ],
          )),
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
                          // return ListTile(
                          //   onLongPress: () => Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => UpdateContact(
                          //               name: data["name"],
                          //               phone: data["phone"],
                          //               job: data["job"],
                          //               docID: document.id))),
                          //   leading: CircleAvatar(child: Text(data["name"][0])),
                          //   title: Text(data["name"]),
                          //   subtitle: Text(data["phone"]),
                          //   trailing: IconButton(
                          //     icon: Icon(Icons.call),
                          //     onPressed: () {
                          //       setState(() {
                          //         callUser(data["phone"]);
                          //       });
                          //       callUser(data["phone"]);
                          //     },
                          //   ),
                          // );

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
