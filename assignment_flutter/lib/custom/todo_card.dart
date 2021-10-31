// ignore_for_file: prefer_const_constructors

import 'package:assignment_flutter/pages/add_to_do.dart';
import 'package:assignment_flutter/pages/edit_data.dart';
import 'package:assignment_flutter/pages/view_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  final Map<String, dynamic> document;

  const TodoCard({
    required this.document,
    Key? key,
    required this.title,
    required this.iconData,
    required this.iconColor,
    required this.deleteIconData,
    required this.deleteIconColor,
    required this.time,
    required this.isCheck,
    required this.iconBgColor,
    required this.id,
  }) : super(key: key);

  final String title;
  final IconData iconData;
  final Color iconColor;
  final String time;
  final bool isCheck;
  final Color iconBgColor;
  final String id;

  final IconData deleteIconData;
  final Color deleteIconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              height: 75,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Color(0xff2a2e3d),
                child: Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 33,
                      width: 36,
                      decoration: BoxDecoration(
                        color: iconBgColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => EditData(
                                        document: document,
                                        id: id,
                                      )));
                        },
                        child: Icon(
                          iconData,
                          color: iconColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 33,
                      width: 36,
                      decoration: BoxDecoration(
                        color: iconBgColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: InkWell(
                        onTap: () {
                          FirebaseFirestore.instance
                              .collection("todo")
                              .doc(id)
                              .delete();
                        },
                        child: Icon(
                          deleteIconData,
                          color: deleteIconColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
