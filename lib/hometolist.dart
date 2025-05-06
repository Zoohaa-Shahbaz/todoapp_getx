import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class todolist extends StatelessWidget {
   todolist({super.key});
  final TextEditingController titlecontroller = TextEditingController();
   final TextEditingController descontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Center(child: Text('To DO List')),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){

      },child: Icon(Icons.add),),

      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: titlecontroller,
            decoration: InputDecoration(hintText: 'Title'),
          ),
          //SizedBox(height: 20,),
        /*  TextField(
            decoration: InputDecoration(hintText: 'Description'),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),*/

          ElevatedButton(onPressed: (){
            Submitdata();
          }, child: Text("Submit")),
        ],
      )
    );


  }

   Future<void> Submitdata() async{
        final  title = titlecontroller.text;
        final bool isCompleted = false;
        final int userId = 5;

        final body = {
          "todo" : title,
          "completed" : isCompleted,
          "userId" : userId,
        };
        final url  = Uri.parse('https://dummyjson.com/todos/add');

        final response = await http.post(url,body: jsonEncode(body),
          headers: { 'Content-Type': 'application/json' },
        );

        if(response.statusCode==201)
        {
          showToast("Todo Added Successfully", Colors.green);
        }
        else {
          showToast("Failed to Add Todo", Colors.red);
        }

        print(response.statusCode);
        print(response.body);



   }
   void showToast(String msg,Color backgroundColor)
   {
     Fluttertoast.showToast(
        msg: msg,
        gravity: ToastGravity.BOTTOM,
         backgroundColor: backgroundColor,
         textColor: Colors.white,
         fontSize: 16.0

     );
   }

   void showSucessMessage(String msg)
   {
      final snackBar = SnackBar(content: Text(msg));
    //  ScaffoldMessenger.of(context).showSnackBar(snackBar);
   }

}
