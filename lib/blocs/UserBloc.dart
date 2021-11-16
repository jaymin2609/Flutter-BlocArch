import 'dart:async';
import 'dart:convert';

import 'package:architecture_action_item/models/User.dart';
import 'package:architecture_action_item/networking/APIProvider.dart';
import 'package:architecture_action_item/networking/Response.dart';
import 'package:architecture_action_item/networking/ReturnType.dart';
import 'package:architecture_action_item/networking/URLS.dart';
import 'package:flutter/material.dart';

abstract class UserEvents {
  const UserEvents();

  @override
  List<Object> get props => [];
}

class GetUsers extends UserEvents {
  const GetUsers({@required this.id});

  final int id;

  @override
  List<Object> get props => [id];
}

class RefreshUsers extends UserEvents {
  const RefreshUsers({@required this.id});

  final int id;

  @override
  List<Object> get props => [id];
}

class UserBloc {
  StreamController _streamControllerUser;

  StreamController _streamControllerUserEvents;

  Stream<ResponseData> get userResponseStream => _streamControllerUser.stream;

  StreamSink<ResponseData> get _userResponseSink => _streamControllerUser.sink;

  StreamSink<UserEvents> get userEventsSink => _streamControllerUserEvents.sink;

  UserBloc() {
    _streamControllerUser = StreamController<ResponseData>.broadcast();
    _streamControllerUserEvents = StreamController<UserEvents>();
    _streamControllerUserEvents.stream.listen(_handleUserEvent);
  }

  _handleUserEvent(event) {
    if (event is GetUsers) {
      print('id : ${event.id}');
      getUsers();
    } else if (event is RefreshUsers) {
      print('id : ${event.id}');
      getUsers();
    }
  }

  void getUsers() async {
    try {
      _userResponseSink.add(ResponseData(
          returnType: ReturnType.GET_USERS,
          status: STATUS.LOADING,
          msg: 'Loading'));

      ResponseData responseData =
          await APIProvider().getCall(ReturnType.GET_USERS, GET_USERS);

      if (responseData.status == STATUS.SUCCESS) {
        var data = json.encode(responseData.data);
        var jsonArray = jsonDecode(data) as List;
        List<User> users =
            jsonArray.map((userObject) => User.fromJson(userObject)).toList();

        responseData.data = users;
      }

      _userResponseSink.add(responseData);
    } catch (e) {
      print(e.toString());
      _userResponseSink.add(ResponseData(
          returnType: ReturnType.GET_USERS,
          status: STATUS.ERROR,
          msg: 'Error!'));
    }
  }

  @override
  void dispose() {
    print('id :dispose');
    _streamControllerUser.close();
    _streamControllerUserEvents.close();
  }
}
