import 'package:flutter/material.dart';
import 'package:sqlite_form/services/form_db_helper.dart';
import 'package:sqlite_form/ui/form/upate_form.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  // List<Map<String, dynamic>> userList = [];

  // _showUsers() async {
  //   userList = await DBHelper.getUsers();
  //   setState(() {});
  // }

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: DBHelper.getUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemBuilder: (context, index) => ListTile(
                          trailing: IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UpdateScreen(
                                              id: snapshot.data![index]['id'],
                                            )));
                              },
                              icon: Icon(Icons.edit)),
                          title: Text(snapshot.data![index]['name'].toString()),
                          subtitle:
                              Text(snapshot.data![index]['phone'].toString()),
                        ),
                    itemCount: snapshot.data!.length);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
        ],
      ),
    );
  }
}
