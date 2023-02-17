import 'package:flutter/material.dart';
import 'package:nota/home.dart';
import 'my_db.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  _AddNotesState createState() => _AddNotesState();
}


class _AddNotesState extends State<AddNotes> {
  // SqlDb sqlDb = SqlDb();
  SqlFliteModel sqlDb = SqlFliteModel();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Notes"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[900],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Form(
                key: formstate,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: note,
                      decoration: InputDecoration(hintText: "title"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: title,
                      decoration: InputDecoration(hintText: "note"),
                    ),
              
                    Container(
                      height: 20,
                    ),
                    MaterialButton( 
                         
                      //shape: CircleBorder(),
                      textColor: Colors.white,
                      color: Colors.lightBlue[900],
                      onPressed: () async {
                        int response = await sqlDb.insertData('''
                            INSERT INTO notes ('note' , 'title' )
                          VALUES ("${title.text}" , "${note.text}")
                          ''');
                        if (response > 0) {
                          //  await   Navigator.of(context).pushNamedAndRemoveUntil(
                          //         MaterialPageRoute(builder: (context) => Home())
                          //             as String,
                          //         (route) => false);
                          await Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        }
                      },
                      child: Text("Add",),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
