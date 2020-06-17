import 'package:flutter/material.dart';
import 'package:flutter_firebase/model/user.dart';
import 'package:flutter_firebase/screens/auth/authenticate.dart';
import 'package:flutter_firebase/screens/home/Home.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);


    if(user== null)
      return Authenticate();
    else
      return Home();
  }
}
