import 'package:architecture_action_item/blocs/UserBloc.dart';
import 'package:architecture_action_item/networking/Response.dart';
import 'package:architecture_action_item/shared/Loading.dart';
import 'package:architecture_action_item/shared/NoDataError.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'file:///D:/Jaymin/Demos/learning_app/lib/blocarchitecture/utility/AppConstants.dart';

import 'UserList.dart';

class HomeWithBloc extends StatefulWidget {
  @override
  _HomeWithBlocState createState() => _HomeWithBlocState();
}

class _HomeWithBlocState extends State<HomeWithBloc> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<UserBloc>(
          create: (context) => UserBloc(),
          dispose: (ctx, userBloc) => userBloc.dispose(),
        )
      ],
      child: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserBloc bloc = Provider.of<UserBloc>(context);
    bloc.userEventsSink.add(GetUsers(id: 10));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(SCREEN_HOME),
        centerTitle: true,
      ),
      body: StreamBuilder<ResponseData>(
          stream: bloc.userResponseStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case STATUS.LOADING:
                  return Loading();
                  break;
                case STATUS.SUCCESS:
                  return Container(
                      padding: EdgeInsets.all(8.0),
                      child: UserList(users: snapshot.data.data));
                  break;
                case STATUS.ERROR:
                  return NoDataError(
                    text: snapshot.data.msg,
                  );
                  break;
              }
            }
            return NoDataError(text: 'No Data');
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          bloc.userEventsSink.add(GetUsers(id: 12));
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
