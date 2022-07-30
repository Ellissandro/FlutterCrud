import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_crud/data/dummy_users.dart';
import 'package:flutter_crud/models/user.dart';

class Users with ChangeNotifier {
  final Map<String, User> _items = {...dummyUsers};

  List<User> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  User byIndex(int i) {
    return _items.values.elementAt(i);
  }

  void put(User user) {
    if (user.id.isNotEmpty && _items.containsKey(user.id)) {
      _updateUser(user);
      return;
    }

    _addUser(user);
  }

  void _addUser(User user) {
    final id = Random().nextDouble().toString();
    _items.putIfAbsent(
      id,
      () => User(
        id: id,
        name: user.name,
        email: user.email,
        avatarUrl: user.avatarUrl,
      ),
    );
    notifyListeners();
  }

  void _updateUser(User user) {
    _items.update(
      user.id,
      (_) => User(
        id: user.id,
        name: user.name,
        email: user.email,
        avatarUrl: user.avatarUrl,
      ),
    );

    notifyListeners();
  }

  void remove(User user) {
    if (user.id.isNotEmpty) {
      _items.remove(user.id);
      notifyListeners();
    }
  }
}
