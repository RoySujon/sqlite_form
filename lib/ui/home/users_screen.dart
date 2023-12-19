import 'package:flutter/material.dart';
import 'package:sqlite_form/models/user_model.dart';
import 'package:sqlite_form/services/user_db.dart';
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
  List<UserModel> newList = [];

  _getUser() async {
    final userList = await UserDB.getUsers();
    setState(() => newList = userList);
  }

  @override
  void initState() {
    _getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: UserDB.getUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemBuilder: (context, index) => ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateScreen(
                                          userModel: snapshot.data![index],
                                        )));
                          },
                          trailing: IconButton(
                              onPressed: () {
                                UserDB.deleteUser(
                                        snapshot.data![index].id.toString())
                                    .then((value) {
                                  setState(() {});
                                });
                              },
                              icon: Icon(Icons.delete)),
                          title: Text(snapshot.data![index].name.toString()),
                          subtitle:
                              Text(snapshot.data![index].createAt.toString()),
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
