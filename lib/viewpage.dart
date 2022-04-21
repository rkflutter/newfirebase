// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:newfirebase/update.dart';
import 'package:shimmer/shimmer.dart';


import 'main.dart';

class view extends StatefulWidget {
  const view({Key? key}) : super(key: key);

  @override
  State<view> createState() => _viewState();
}

class _viewState extends State<view> {
  List<Widget> rr = [viewdata(), login()];
  int cnt = 0;

  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("view product"),
        ),
        drawer: Drawer(
          child: Container(
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 5),
                  color: Colors.yellowAccent,
                  child: ListTile(
                    onTap: () {
                      setState(() {
                        cnt = 0;
                      });
                      Navigator.pop(context);
                    },
                    leading:
                    Icon(Icons.shopping_cart_outlined, color: Colors.blue),
                    title: Text("view Product"),
                    trailing: Icon(Icons.arrow_forward, color: Colors.blue),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 5),
                  color: Colors.yellowAccent,
                  child: ListTile(
                    onTap: () {
                      setState(() {
                        cnt = 1;
                      });
                      Navigator.pop(context);
                    },
                    leading: Icon(Icons.add, color: Colors.blue),
                    title: Text("Add Product"),
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: rr[cnt],
      ),
    );
  }
}

class viewdata extends StatefulWidget {
  const viewdata({Key? key}) : super(key: key);

  @override
  State<viewdata> createState() => _viewdataState();
}

class _viewdataState extends State<viewdata> {
  List ll = [];
  bool stu = false;

  void initState() {
    // TODO: implement initState
    super.initState();

    getdata();
  }

  getdata() async {
    Future.delayed(Duration(seconds: 8));


    DatabaseReference ref = FirebaseDatabase.instance.ref("rohit");
    DatabaseEvent de = await ref.once();

    Map m = de.snapshot.value as Map;



    m.forEach((key, value) {
      ll.add(value);
      setState(() {});
      print(ll);
    });
    setState(() {
      stu = true;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: stu ? ListView.builder(
          itemCount: ll.length,
          itemBuilder: (context, index) {
            return Container(
              height: 120,

              width: double.infinity - 10,

              child: Card(
                color: Colors.white,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(5),


                      child: CircleAvatar(
                        radius: 42,
                        backgroundColor: Colors.blue,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                              "https://play-lh.googleusercontent.com/bYtqbOcTYOlgc6gqZ2rwb8lptHuwlNE75zYJu6Bn076-hTmvd96HH-6v7S0YUAAJXoJN=s180-rw"),
                        ),
                      ),


                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                            height: 25,
                            width: 180,

                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                                "${ll[index]['prname']}", style: TextStyle(
                                fontSize: 25))),
                        Container(

                            height: 20,
                            width: 180,

                            padding: EdgeInsets.only(left: 5),

                            margin: EdgeInsets.only(
                                left: 15, top: 10, bottom: 10),
                            child: Text(
                                "${ll[index]['prprice']}", style: TextStyle(
                                fontSize: 18))),
                        Container(

                            height: 20,
                            width: 180,

                            padding: EdgeInsets.only(left: 10),


                            child: Text(
                                "${ll[index]['decription']}", style: TextStyle(
                                fontSize: 18)))

                      ],
                    ),

                    PopupMenuButton(
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            onTap: (){
                              setState(() {
                                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) {
                                  return update(ll,index);
                                },));
                              });
                            },
                            child: Text("Update"),
                          ),
                          PopupMenuItem(
                            child: Text("Delete"),
                          )
                        ];
                      },
                      icon: Icon(Icons.more_vert),
                    )


                  ],
                ),
              ),
            );
          },


        ) : ListView.builder(
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.black12,
              highlightColor: Colors.grey[300]!,
              period: Duration(seconds: 2),
              child: Container(
                width: double.infinity - 30,
                height: 120,
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.grey[400]!,
                ),
              ),
            );
          },
          itemCount: 4,
        )



    // GridView.builder(
    //     itemCount: ll.length,
    //     shrinkWrap: true,
    //     itemBuilder: (context, index) {
    //       return Center(
    //         child: Card(
    //           elevation: 50,
    //           shadowColor: Colors.black,
    //           color: Colors.greenAccent[100],
    //           child: SizedBox(
    //             width: 300,
    //             height: 500,
    //             child: Padding(
    //               padding: const EdgeInsets.all(10),
    //               child: Column(
    //                 children: [
    //                   Stack(
    //                     children: [
    //                       Row(
    //                         mainAxisAlignment: MainAxisAlignment.end,
    //                         children: [
    //                           PopupMenuButton(
    //                             onSelected: (value) {
    //                               if (value == 0) {
    //                                 Navigator.pushReplacement(context,
    //                                     MaterialPageRoute(
    //                                       builder: (context) {
    //                                         return update(ll,index);
    //                                       },
    //                                     ));
    //                               }
    //                               if (value == 1) {
    //                                 // Navigator.push(
    //                                 //     context,
    //                                 //     MaterialPageRoute(
    //                                 //       builder: (context) {
    //                                 //         return update();
    //                                 //       },
    //                                 //     ));
    //                               }
    //                             },
    //                             itemBuilder: (context) {
    //                               return [
    //                                 PopupMenuItem(
    //                                     value: 0, child: Text("Update",)),
    //                                 PopupMenuItem(
    //                                     value: 1, child: Text("Delete")),
    //                                 //PopupMenuItem(child: Text("Text"))
    //                               ];
    //                             },
    //                           ),
    //
    //
    //                         ],
    //                       ),
    //                       Row(
    //                         mainAxisAlignment: MainAxisAlignment.center,
    //                         children: [
    //                           CircleAvatar(
    //                             backgroundColor: Colors.green[500],
    //                             radius: 30,
    //
    //                             // backgroundImage: NetworkImage(
    //                             //     "https://pbs.twimg.com/profile_images/1304985167476523008/QNHrwL2q_400x400.jpg"),
    //                             // //NetworkImage
    //
    //                             //CircleAvatar
    //                           ),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                   //CircleAvatar
    //                   SizedBox(
    //                     height: 5,
    //                   ), //SizedBox
    //                   Text(
    //                     '${ll[index]['prname']}',
    //                     style: TextStyle(
    //                       fontSize: 20,
    //                       color: Colors.green[900],
    //                       fontWeight: FontWeight.w500,
    //                     ), //Textstyle
    //                   ), //Text
    //                   //SizedBox
    //                   Text(
    //                     '${ll[index]['prprice']}',
    //                     style: TextStyle(
    //                       fontSize: 20,
    //                       color: Colors.green[900],
    //                     ), //Textstyle
    //                   ),
    //                   Text(
    //                     '${ll[index]['decription']}',
    //                     style: TextStyle(
    //                       fontSize: 20,
    //                       color: Colors.green[900],
    //                     ), //Textstyle
    //                   ), //Text
    //                   //SizedBox
    //                   //SizedBox
    //                 ],
    //               ), //Column
    //             ), //Padding
    //           ), //SizedBox
    //         ),
    //
    //         //Card
    //       );
    //     },
    //     gridDelegate:
    //     SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2))


    );
  }
}
