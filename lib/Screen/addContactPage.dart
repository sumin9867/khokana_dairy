// import 'package:flutter/material.dart';
// import 'package:phonebook/controller/CRUD.dart';

// class AddContact extends StatefulWidget {
//   const AddContact({super.key});

//   @override
//   State<AddContact> createState() => _AddContactState();
// }

// class _AddContactState extends State<AddContact> {
//   TextEditingController _nameController = TextEditingController();
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _phoneController = TextEditingController();
//   TextEditingController _toleController = TextEditingController();
//   TextEditingController _jobController = TextEditingController();
//   TextEditingController _kunaController = TextEditingController();
//   final formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Add Contact")),
//       body: SingleChildScrollView(
//         child: Form(
//           key: formKey,
//           child: Center(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 20,
//                 ),
//                 SizedBox(
//                     width: MediaQuery.of(context).size.width * .9,
//                     child: TextFormField(
//                       validator: (value) =>
//                           value!.isEmpty ? "Enter any name" : null,
//                       controller: _nameController,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         label: Text("Name"),
//                       ),
//                     )),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 SizedBox(
//                     width: MediaQuery.of(context).size.width * .9,
//                     child: TextFormField(
//                       controller: _phoneController,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         label: Text("Phone"),
//                       ),
//                     )),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 SizedBox(
//                     width: MediaQuery.of(context).size.width * .9,
//                     child: TextFormField(
//                       controller: _emailController,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         label: Text("Email"),
//                       ),
//                     )),
//                 SizedBox(
//                     width: MediaQuery.of(context).size.width * .9,
//                     child: TextFormField(
//                       controller: _toleController,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         label: Text("Tole"),
//                       ),
//                     )),
//                 SizedBox(
//                     width: MediaQuery.of(context).size.width * .9,
//                     child: TextFormField(
//                       controller: _jobController,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         label: Text("Occupation"),
//                       ),
//                     )),
//                 SizedBox(
//                     width: MediaQuery.of(context).size.width * .9,
//                     child: TextFormField(
//                       controller: _kunaController,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         label: Text("Kuna"),
//                       ),
//                     )),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 SizedBox(
//                     height: 65,
//                     width: MediaQuery.of(context).size.width * .9,
//                     child: ElevatedButton(
//                         onPressed: () {
//                           if (formKey.currentState!.validate()) {
//                             CRUDService().addNewContacts(
//                                 _nameController.text,
//                                 _phoneController.text,
//                                 _emailController.text,
//                                 _jobController.text,
//                                 _kunaController.text,
//                                 _toleController.text);
//                             Navigator.pop(context);
//                           }
//                         },
//                         child: Text(
//                           "Create",
//                           style: TextStyle(fontSize: 16),
//                         ))),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:phonetest/controller/CRUD.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _toleController = TextEditingController();
  TextEditingController _jobController = TextEditingController();
  TextEditingController _kunaController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Contact")),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    child: TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? "Enter any name" : null,
                      controller: _nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Name"),
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    child: TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Phone"),
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Email"),
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    child: TextFormField(
                      controller: _toleController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Tole"),
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    child: TextFormField(
                      controller: _kunaController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("kuna"),
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    child: TextFormField(
                      controller: _jobController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("jon"),
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                    height: 65,
                    width: MediaQuery.of(context).size.width * .9,
                    child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            CRUDService().addNewContacts(
                                _nameController.text,
                                _phoneController.text,
                                _emailController.text,
                                _toleController.text,
                                _jobController.text,
                                _kunaController.text);
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          "Create",
                          style: TextStyle(fontSize: 16),
                        ))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
