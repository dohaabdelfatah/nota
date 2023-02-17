import 'package:flutter/material.dart';
import 'package:nota/home.dart';
import 'my_db.dart';

class EditNotes extends StatefulWidget {
  final Map noteData;
  const EditNotes({Key? key,  required this.noteData})
      : super(key: key);

  @override
  _EditNotesState createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  // SqlDb sqlDb = SqlDb();
  SqlFliteModel sqlDb = SqlFliteModel();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  //TextEditingController color = TextEditingController();

  @override
  void initState() {
    note.text = widget.noteData['note'];
    title.text = widget.noteData['title'];
    //color.text = widget.Color;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[900],
        title: Text("Edit Notes"),
        centerTitle: true,
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
                      decoration: InputDecoration(hintText: "note"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: title,
                      decoration: InputDecoration(hintText: "title"),
                    ),
                    
                    Container(
                      height: 20,
                    ),
                    MaterialButton(
                      textColor: Colors.white,
                      color: Colors.lightBlue[900],
                      onPressed: () async {
                        int response = await sqlDb.updateData("UPDATE notes SET note = '${note.text}', title = '${title.text}' WHERE id = ${widget.noteData['id']}");
                        if (response > 0) {
                          //  await   Navigator.of(context).pushNamedAndRemoveUntil(
                          //         MaterialPageRoute(builder: (context) => Home())
                          //             as String,
                          //         (route) => false);
                          await Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        }
                      },
                      child: Text("Edit"),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
