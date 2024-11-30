import 'dart:convert';

import 'package:f08_eshop_app/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class UserList with ChangeNotifier {
  final _baseUrl = 'https://ddm20242-94e9c-default-rtdb.firebaseio.com/';

  List<User> _users = [];
  User? _loggedUser;

  List<User> get users {
    return [..._users];
  }

  User? get loggedUser => _loggedUser;

  Future<List<User>> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/users.json'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> usersJson =
            jsonDecode(response.body == "null" ? "{}" : response.body);

        final fetchedUsers = usersJson.entries.map((entry) {
          return User.fromJson(entry.key, entry.value);
        }).toList();

        _users = fetchedUsers;
        notifyListeners();

        return fetchedUsers;
      } else {
        throw Exception("Aconteceu algum erro na requisição");
      }
    } catch (e) {
      throw Exception("Erro ao buscar usuários: $e");
    }
  }

  Future<void> addUser(User user) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/users.json'),
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 200) {
        final id = jsonDecode(response.body)['name'];
        final newUser = User(
          id: id,
          name: user.name,
          email: user.email,
          password: user.password,
        );
        _users.add(newUser);
        notifyListeners();
      } else {
        throw Exception("Aconteceu algum erro ao adicionar o usuário");
      }
    } catch (e) {
      throw Exception("Erro ao adicionar usuário: $e");
    }
  }

  Future<void> updateUser(User user) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/users/${user.id}.json'),
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 200) {
        final index = _users.indexWhere((u) => u.id == user.id);
        if (index >= 0) {
          _users[index] = user;
          notifyListeners();
        }
      } else {
        throw Exception("Aconteceu algum erro ao atualizar o usuário");
      }
    } catch (e) {
      throw Exception("Erro ao atualizar usuário: $e");
    }
  }

  Future<void> removeUser(User user) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/users/${user.id}.json'),
      );

      if (response.statusCode == 200) {
        _users.removeWhere((u) => u.id == user.id);
        notifyListeners();
      } else {
        throw Exception("Aconteceu algum erro ao remover o usuário");
      }
    } catch (e) {
      throw Exception("Erro ao remover usuário: $e");
    }
  }

  Future<bool> login(String email, String password) async {
    final users = await fetchUsers();

    _loggedUser = users
        .where((user) => user.email == email && user.password == password)
        .firstOrNull;

    notifyListeners();

    return _loggedUser != null;
  }

  void logout() {
    _loggedUser = null;

    notifyListeners();
  }
}
