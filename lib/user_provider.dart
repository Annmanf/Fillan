/**
 * import 'package:fil_lan/service/auth_services.dart';
import 'package:fil_lan/src/users.dart';
import 'package:flutter/widgets.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthService _authMethods = AuthService();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    //User user = await _authMethods.getUserDetails();
    //_user = user;
    notifyListeners();
  }
}

 */