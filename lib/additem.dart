import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'hometolist.dart';

class Additem extends StatefulWidget {
   Additem({super.key});

  @override
  State<Additem> createState() => _AdditemState();
}

class _AdditemState extends State<Additem> {
  List items = [];

  @override
  void initState() {
    // TODO: implement initState
    getData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Todo List"),),

      ),

      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        NavtoPage(context);

      }, label: Text("Add toDO")),

      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            title: Text(item['todo'].toString()),
            leading: CircleAvatar(
              child: Text(item['id'].toString()),
            ),
            trailing: Icon(
              item['completed'] ? Icons.check_circle : Icons.radio_button_unchecked,
              color: item['completed'] ? Colors.green : Colors.grey,
            ),
          );

      },),
    );


  }

  void NavtoPage(BuildContext context) {
    final route = MaterialPageRoute(builder: (context) => todolist());
    Navigator.push(context, route);


  }

  Future<void> getData() async
  {
    final url = Uri.parse('https://dummyjson.com/todos');
    final res = http.get(url);
    final response = await http.get(url);
    if(response.statusCode==200)
      {
        final json = jsonDecode(response.body);
        final rescult = json['todos'] as List;

        setState(() {
          items = rescult;
        });


      }

      print(response.statusCode);
    print(response.body);

  }
}
