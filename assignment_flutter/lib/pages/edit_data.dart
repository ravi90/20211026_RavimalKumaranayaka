// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:assignment_flutter/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditData extends StatefulWidget {
  EditData({Key? key, required this.document, required this.id})
      : super(key: key);
  final Map<String, dynamic> document;
  final String id;

  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  String type = "";
  String category = "";

  late DateTime pickedDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pickedDate = DateTime.now();

    String title = widget.document["title"] == ""
        ? "Title Unavailable"
        : widget.document["title"];
    titleController = TextEditingController(text: title);

    descriptionController =
        TextEditingController(text: widget.document["description"]);
    type = widget.document["task"];
    category = widget.document["category"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xff1d1e26),
          Color(0xff1252041),
        ])),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  CupertinoIcons.arrow_left,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Edit",
                        style: TextStyle(
                          fontSize: 33,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Todo Information",
                        style: TextStyle(
                          fontSize: 33,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      label("Task Title"),
                      SizedBox(
                        height: 12,
                      ),
                      title(),
                      SizedBox(
                        height: 30,
                      ),
                      label("Task Type"),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          taskSelect("Important", 0xff2662fa),
                          SizedBox(
                            width: 20,
                          ),
                          taskSelect("Planned", 0xff4caf50),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      label("Description"),
                      SizedBox(
                        height: 12,
                      ),
                      description(),
                      SizedBox(
                        height: 25,
                      ),
                      label("Category"),
                      SizedBox(
                        height: 12,
                      ),
                      Wrap(
                        children: [
                          categorySelect("WorkOut", 0xffff6d6e),
                          SizedBox(
                            width: 20,
                          ),
                          categorySelect("Work", 0xfff29732),
                          SizedBox(
                            width: 20,
                          ),
                          categorySelect("Medicine", 0xff6557ff),
                          SizedBox(
                            width: 20,
                          ),
                          categorySelect("Food", 0xff2662fa),
                          SizedBox(
                            width: 20,
                          ),
                          categorySelect("Other", 0xff2bc8d9),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      label("Date"),
                      SizedBox(
                        height: 12,
                      ),
                      ListTile(
                        title: Text(
                          "Date: " + widget.document["date"],
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            //fontWeight: FontWeight.w600,
                          ),
                        ),
                        trailing: Icon(
                          Icons.access_time_outlined,
                          size: 25,
                          color: Colors.grey,
                        ),
                        onTap: _pickDate,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      button(),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  _pickDate() async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: pickedDate,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));

    if (date != null) {
      setState(() {
        pickedDate = date;
      });
    }
  }

  Widget button() {
    return InkWell(
      onTap: () {
        FirebaseFirestore.instance.collection("todo").doc(widget.id).update(({
              "title": titleController.text,
              "task": type,
              "description": descriptionController.text,
              "category": category,
              "date":
                  " ${pickedDate.year},${pickedDate.month},${pickedDate.day}"
            }));
        Navigator.pop(context);
      },
      child: Container(
        height: 55,
        width: MediaQuery.of(context).size.width - 80,
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                Color(0xff2e7d32),
                Color(0xff2e7d32),
              ],
            )),
        child: Center(
          child: Text("Update",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              )),
        ),
      ),
    );
  }

  Widget description() {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: descriptionController,
        style: TextStyle(color: Colors.grey, fontSize: 17),
        maxLines: null,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Description",
            hintStyle: TextStyle(color: Colors.grey, fontSize: 17),
            contentPadding: EdgeInsets.only(
              left: 20,
              right: 20,
            )),
      ),
    );
  }

  Widget taskSelect(String label, int color) {
    return InkWell(
      onTap: () {
        setState(() {
          type = label;
        });
      },
      child: Chip(
        backgroundColor: type == label ? Colors.pink : Color(color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        label: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 4),
      ),
    );
  }

  Widget categorySelect(String label, int color) {
    return InkWell(
      onTap: () {
        setState(() {
          category = label;
        });
      },
      child: Chip(
        backgroundColor: category == label ? Colors.pink : Color(color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        label: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 4),
      ),
    );
  }

  Widget title() {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: titleController,
        style: TextStyle(color: Colors.grey, fontSize: 17),
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Task Title",
            hintStyle: TextStyle(color: Colors.grey, fontSize: 17),
            contentPadding: EdgeInsets.only(
              left: 20,
              right: 20,
            )),
      ),
    );
  }

  Widget label(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 16.5,
        color: Colors.white,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
    );
  }
}
