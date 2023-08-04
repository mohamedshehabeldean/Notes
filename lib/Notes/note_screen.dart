import 'package:flutter/material.dart';
import 'package:hive01/Notes/hive/hive_helper.dart';
class noteScreen extends StatefulWidget {
  const noteScreen({Key? key}) : super(key: key);
  @override

  State<noteScreen> createState() => _noteScreenState();
}

class _noteScreenState extends State<noteScreen> {
  final _textFieldController=TextEditingController();
  @override
  void initState() {
    hiveHelper.getnote(_refresh);
    super.initState();
  }
  void _refresh(){
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          await showDialog(
              context: context,
              builder: (context) {return AlertDialog(
                  title: const Text('Note'),
                  content: TextField(
                    controller: _textFieldController,
                    decoration: const InputDecoration(hintText: "enter your note"),
                  ),
                  actions:[
                    MaterialButton(
                      child:  Text("Cancel"),
                      onPressed: () => Navigator.pop(context),
                    ),
                    MaterialButton(
                      child:  Text('OK'),
                      onPressed: () {
                        if(_textFieldController.text.isNotEmpty){
                          hiveHelper.add(_textFieldController.text);
                        }

                        Navigator.pop(context);


                      }
                    ),
                  ],
                );
              }
              ).then((value) =>  setState(() {}));
        }
        ,
        child: Icon(Icons.add,size: 40,),
      ),
      appBar: AppBar(
        leading: InkWell(
            onTap: (){
              hiveHelper.clearallnotes(_refresh);
            },
            child: Icon(Icons.delete)),
        title: Text("Notes",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700),),
        centerTitle: true,

      ),
      body:hiveHelper.notes.isEmpty?Center(child: CircularProgressIndicator(),):
      ListView.separated(
        padding: EdgeInsets.all(15),

          itemBuilder: (context,index)=>_buildNoteItem(text: hiveHelper.notes[index],index: index),
          separatorBuilder: (context,index)=>SizedBox(
            height: 10.0,
          ),
          itemCount: hiveHelper.notes.length
      ),


    );
  }

 Widget _buildNoteItem( {
  required String text,
  required int index
}) {
    return Stack(
      children: [
        Container(
          width: 400,
          height: 200,
          child: Center(
              child: Text(text,style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),)),
          decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(20)
          ),

        ),
        InkWell(
          onTap: (){
            hiveHelper.remove(index);
            _refresh();


          },
            child: Icon(Icons.remove_circle,color: Colors.red,size: 40,)
        ),
        Padding(
          padding: const EdgeInsets.only(left: 320.0),
          child: InkWell(
              onTap: () async{
                _textFieldController.text=hiveHelper.notes[index];
                // hiveHelper.update(index,);
                // _refresh();

                  await showDialog(
                      context: context,
                      builder: (context) {return AlertDialog(
                    title: const Text('Note'),
                    content: TextField(
                      controller: _textFieldController,
                      decoration: const InputDecoration(hintText: "enter your note"),
                    ),
                    actions:[
                      MaterialButton(
                        child:  Text("Cancel"),
                        onPressed: () => Navigator.pop(context),
                      ),
                      MaterialButton(
                          child:  Text('OK'),
                          onPressed: () {
                            if(_textFieldController.text.isNotEmpty){
                              hiveHelper.update(index,_textFieldController.text);

                            }

                            Navigator.pop(context);


                          }
                      ),
                    ],
                  );
                  }
                ).then((value) =>  setState(() {}));



              },
              child: Icon(Icons.edit,color: Colors.red,size: 40,)
          ),
        )

      ],
    );
  }

}
