// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:assignment_flutter/custom/todo_card.dart';
import 'package:assignment_flutter/pages/add_to_do.dart';
import 'package:assignment_flutter/pages/sign_up_page.dart';
import 'package:assignment_flutter/pages/view_data.dart';
import 'package:assignment_flutter/service/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //late int length = 0;

  //late Map<String, dynamic> fireStoreData;

  /*int getLength() {
    FirebaseFirestore.instance.collection("todo").get().then((querySnapshot) {
      length = 0;
      querySnapshot.docs.forEach((result) {
        //length = result.data().length;
        length++;
      });
    });

    return length;
  }*/

  /*Map<String, dynamic> getData() {
    FirebaseFirestore.instance.collection("todo").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        fireStoreData = result.data();
      });
    });
    return fireStoreData;
  }*/

  AuthClass authClass = AuthClass();

  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection("todo").orderBy("date").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          "",
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await authClass.logOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (builder) => SignUpPage()),
                    (route) => false);
              }),
          SizedBox(
            width: 10,
          )
        ],
        bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.only(left: 22, bottom: 10),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Todos List",
                  style: TextStyle(
                      fontSize: 33,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ),
            preferredSize: Size.fromHeight(35)),
      ),
      bottomNavigationBar:
          BottomNavigationBar(backgroundColor: Colors.black87, items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: 32,
            color: Colors.black87,
          ),
          title: Container(),
        ),
        BottomNavigationBarItem(
          icon: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => AddToDoPage()));
            },
            child: Container(
              height: 72,
              width: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [
                  Colors.indigoAccent,
                  Colors.purple,
                ]),
              ),
              child: Icon(
                Icons.add,
                size: 32,
                color: Colors.white,
              ),
            ),
          ),
          title: Container(),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
            size: 32,
            color: Colors.black87,
          ),
          title: Container(),
        ),
      ]),
      body: StreamBuilder<QuerySnapshot>(
          stream: _stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  IconData iconData = Icons.edit;
                  Color iconColor = Colors.green;
                  IconData deleteIconData = Icons.delete;
                  Color deleteIconColor = Colors.red;
                  Map<String, dynamic> document =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => ViewData(
                                    document: document,
                                  )));
                    },
                    child: TodoCard(
                      document: document,
                      title: document["title"] == ""
                          ? "Title Unavailable"
                          : document["title"],
                      isCheck: true,
                      iconBgColor: Colors.white,
                      iconColor: iconColor,
                      iconData: iconData,
                      deleteIconData: deleteIconData,
                      deleteIconColor: deleteIconColor,
                      time: document["date"],
                      id: snapshot.data!.docs[index].id,
                    ),
                  );
                });
          }),
    );
  }
}
