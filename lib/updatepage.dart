import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:realtimedatabase/viewdata.dart';

class updatepage extends StatefulWidget {
  Map m;
  updatepage(this.m);

  @override
  State<updatepage> createState() => _updatepageState();
}

class _updatepageState extends State<updatepage> {
  TextEditingController tname = TextEditingController();
  TextEditingController tcontact = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tname.text=widget.m['name'];
    tcontact.text=widget.m['contact'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("insert page"),
      ),
      body: Column(
        children: [
          TextField(
            controller: tname,
          ),
          TextField(
            controller: tcontact,
          ),
          ElevatedButton(
              onPressed: () {
                String name = tname.text;
                String contact = tcontact.text;
                FirebaseDatabase.instance
                    .ref("contactbook")
                    .child(widget.m['userid'])
                    .update({'name': name, 'contact': contact});

                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return viewpage();
                  },
                ));
              },
              child: Text("submit"))
        ],
      ),
    );
  }
}
