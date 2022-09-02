import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:realtimedatabase/insertdata.dart';
import 'package:realtimedatabase/updatepage.dart';

class viewpage extends StatefulWidget {
  const viewpage({Key? key}) : super(key: key);

  @override
  State<viewpage> createState() => _viewpageState();
}

class _viewpageState extends State<viewpage> {
  List l = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loaddata();
  }

  loaddata() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("contactbook");
    DatabaseEvent de = await ref.once();
    DataSnapshot ds = de.snapshot;
    print(ds);
    Map map = ds.value as Map;
    map.forEach((key, value) {
      l.add(value);
    });
    setState(() {
      print(l);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return insertpage();
            },
          ));
        },
        child: Text("add"),
      ),
      appBar: AppBar(
        title: Text("View page"),
      ),
      body: l.length > 0
          ? ListView.builder(
              itemCount: l.length,
              itemBuilder: (context, index) {
                Map m = l[index];
                return ListTile(
                  onLongPress: () {
                    showDialog(
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Delete data"),
                            content: Text("Are you sure you want to delete"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    FirebaseDatabase.instance
                                        .ref("contactbook")
                                        .child(m['userid'])
                                        .remove();
                                    setState(() {});
                                  },
                                  child: Text("Yes")),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("No"))
                            ],
                          );
                        },
                        context: context);
                  },
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return updatepage(m);
                      },
                    ));
                  },
                  title: Text("${m['name']}"),
                  subtitle: Text("${m['contact']}"),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
