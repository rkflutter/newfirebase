
// ignore_for_file: prefer_const_constructors, deprecated_member_use, camel_case_types, avoid_print, must_be_immutable, use_key_in_widget_constructors, unused_local_variable

import 'dart:io';
import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newfirebase/viewpage.dart';


// void main() {
//
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: login(),
//   ) );
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: view(),
    builder: EasyLoading.init(),



  ));
}
class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {

  final ImagePicker _picker = ImagePicker();
  TextEditingController prname=TextEditingController();
  TextEditingController prprice=TextEditingController();
  TextEditingController decription=TextEditingController();

  final storageRef = FirebaseStorage.instance.ref();


  String str = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Center(
            child: str!=""
                ?CircleAvatar(
              radius: 60,
              backgroundImage: str!=""?FileImage(File(str)):FileImage(File(str)),
              child: Align(
                alignment: Alignment.bottomRight,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,

                  child: IconButton(

                      onPressed: (){

                        showDialog(builder: (context) {
                          return SimpleDialog(
                            children: [
                              RaisedButton.icon(onPressed: () async {
                                Navigator.pop(context);
                                final XFile? gallery = await _picker.pickImage(
                                    source: ImageSource.gallery);
                                setState(() {
                                  str =gallery!.path;
                                });

                              }, icon: Icon(Icons.browse_gallery), label: Text("Gallery")
                              ),
                              RaisedButton.icon(onPressed: () async {
                                Navigator.pop(context);
                                final XFile? photo = await _picker.pickImage(
                                    source: ImageSource.camera);
                                setState(() {
                                  str=photo!.path;
                                });

                              }, icon: Icon(Icons.camera), label: Text("camera")),
                              RaisedButton.icon(onPressed: () {
                                setState(() {
                                  str="";
                                });
                              }, icon: Icon(Icons.people), label: Text("REMOVE PHOTOS")),

                            ],
                          );
                        },context: context);
                      },
                      icon: Icon(

                        Icons.edit,color: Colors.deepOrange,
                        size: 20,
                      )
                  ),
                ),
              ),

            ):CircleAvatar(
              radius: 60,
              backgroundImage:AssetImage("images/images.png"),
              child: Align(
                alignment: Alignment.bottomRight,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,

                  child: IconButton(

                      onPressed: (){

                        showDialog(builder: (context) {
                          return SimpleDialog(
                            children: [
                              RaisedButton.icon(onPressed: () async {
                                Navigator.pop(context);
                                final XFile? gallery = await _picker.pickImage(
                                    source: ImageSource.gallery);
                                setState(() {
                                  str =gallery!.path;
                                });

                              }, icon: Icon(Icons.browse_gallery), label: Text("Gallery")
                              ),
                              RaisedButton.icon(onPressed: () async {
                                Navigator.pop(context);
                                final XFile? photo = await _picker.pickImage(
                                    source: ImageSource.camera);
                                setState(() {
                                  str=photo!.path;
                                });

                              }, icon: Icon(Icons.camera), label: Text("camera")),
                              RaisedButton.icon(onPressed: () {
                                setState(() {
                                  str="";
                                });
                              }, icon: Icon(Icons.people), label: Text("REMOVE PHOTOS")),

                            ],
                          );
                        },context: context);
                      },
                      icon: Icon(

                        Icons.edit,color: Colors.deepOrange,
                        size: 20,
                      )
                  ),
                ),
              ),
            ),

          ),

          Container(
            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: TextField(
              controller: prname,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.people),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 3),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black12, width: 3),
                  ),
                  labelText: "product Name",
                  hintText: "Enter product Name"),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: TextField(
              controller: prprice,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.money_off),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 3),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black12, width: 3),
                  ),
                  labelText: "product price",
                  hintText: "Enter product price Name"),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: TextField(
              controller: decription,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.description),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 3),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black12, width: 3),
                  ),
                  labelText: "decription",
                  hintText: "Enter product decription "),
            ),
          ),

          ElevatedButton(onPressed: () async {
            EasyLoading.show(status: 'loading...');
            Future.delayed(Duration(seconds: 2));
            String imagename =
                "${Random().nextInt(1000)}.jpg";

            String imgname="";
            final spaceRef = storageRef.child("rohit/$imagename");
            spaceRef.putFile(File(str));
            setState(() {});
            spaceRef.getDownloadURL().then((value) {
              setState(() {
                imgname=value;
              });
              print("====$imgname");
            });

            DatabaseReference ref =
            FirebaseDatabase.instance.ref("rohit").push();
            String? id = ref.key;

            await ref.set({
              "id": id,
              "prname": prname.text,
              "prprice":prprice.text,
              "decription":decription.text,
               "image":imagename,

            });
            EasyLoading.dismiss();

            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return view();
            },));


          }, child: Text("submit"))
        ],
      ),
    );
  }
}


