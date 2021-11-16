import 'package:architecture_action_item/models/User.dart';
import 'package:flutter/material.dart';

import 'UserDetails.dart';

class UserList extends StatelessWidget {
  final List<User> users;

  const UserList({Key key, this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserDetails(user: users[index])));
            },
            title: Text('${users[index].name}'),
            subtitle: Text('${users[index].email}'),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Hero(
                tag: 'location-${users[index].id}',
                child: Container(
                  color: Colors.red,
                  width: 50.0,
                  height: 50.0,
                  child: Center(
                    child: Text(
                      '${users[index].name.substring(0, 1)}',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
