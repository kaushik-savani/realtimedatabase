import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:realtimedatabase/viewdata.dart';

class insertpage extends StatefulWidget {
  const insertpage({Key? key}) : super(key: key);

  @override
  State<insertpage> createState() => _insertpageState();
}

class _insertpageState extends State<insertpage> {
  TextEditingController tname=TextEditingController();
  TextEditingController tcontact=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("insert page"),),
      body: Column(children: [TextField(controller: tname,),TextField(controller: tcontact,),
      ElevatedButton(onPressed: () {
        DatabaseReference ref = FirebaseDatabase.instance.ref("contactbook").push();

        String? userid=ref.key;
        String name=tname.text;
        String contact=tcontact.text;

        Map map={"userid":userid,"name":name,"contact":contact};

        ref.set(map);

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return viewpage();
        },));
      }, child: Text("submit"))],),
    );
  }
}
