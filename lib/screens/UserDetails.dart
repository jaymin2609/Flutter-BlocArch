import 'package:architecture_action_item/models/User.dart';
import 'package:architecture_action_item/shared/heart.dart';
import 'package:flutter/material.dart';
import 'package:lipsum/lipsum.dart' as lipsum;

class UserDetails extends StatelessWidget {
  final User user;

  UserDetails({@required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              child: Hero(
                tag: 'location-${user.id}',
                child: Container(
                  color: Colors.red,
                  height: 360.0,
                  child: Center(
                    child: Text(
                      '${user.userName}',
                      style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            ListTile(
                title: Text(user.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.grey[800])),
                subtitle:
                    Text('${user.email}', style: TextStyle(letterSpacing: 1)),
                trailing: Heart()),
            Padding(
                padding: EdgeInsets.all(18),
                child: Text(
                    lipsum.createText(numParagraphs: 1, numSentences: 3),
                    style: TextStyle(color: Colors.grey[600], height: 1.4))),
          ],
        ),
      ),
    );
  }
}
