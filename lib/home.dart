import 'package:flutter/material.dart';
import 'package:nota/editnotes.dart';
//import 'package:note_app/sqldb.dart';

import 'my_db.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SqlFliteModel sqlDb = SqlFliteModel();

  //SqlDb sqlDb = SqlDb();
  bool isLoading = true;
  List notes = [];

  Future readData() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM notes ");
    print(response);
    notes.addAll(response);
    isLoading = false;
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromARGB(255, 93, 1, 116),
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[900],
        title: Text('NOTES'),
        centerTitle: true,
      
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue[900],
        onPressed: () {
          Navigator.of(context).pushNamed("AddNotes");
        },
        child: Icon(Icons.add , size: 30,),
      ),
      
      body: isLoading == true
          ? Center(child: Text("Loading...."))
          : Container(
              child: ListView(
                children: [
                  ListView.builder(
                      itemCount: notes.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        return Card(
                          child: ListTile(
                              title: Text("${notes[i]["title"]}"),
                              subtitle: Text("${notes[i]["note"]}"),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      int response = await sqlDb.deleteData(
                                          "DELETE FROM notes WHERE id = ${notes[i]['id']}");

                                      if (response > 0) {
                                        notes.removeWhere(
                                            (element) => element['id'] == notes[i]['id']);

                                        setState(() {});
                                      }
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => EditNotes(
                                                    noteData: notes[i],
                                                  )));
                                      //Navigator.of(context).push(
                                      //MaterialPageRoute(builder:(context)=>EditNotes())
                                      //)
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              )),
                        );
                      })
                ],
              ),
            ),
    );
  }
}
