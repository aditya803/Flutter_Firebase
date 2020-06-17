import 'package:flutter/material.dart';
import 'package:flutter_firebase/auth/auth.dart';
import 'package:flutter_firebase/shared/constant.dart';
import 'package:flutter_firebase/shared/loading.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //setting state
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        actions: <Widget>[
          FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Sign In'),
              onPressed: (){
                widget.toggleView();
              }
          ),
        ],
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign Up'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 90.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val)=> val.isEmpty ? 'enter an email': null,
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val)=> val.length< 6 ? 'enter a password more than 6 characters': null,
                obscureText: true,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.brown[400],
                child: Text('Register',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                onPressed: () async{
                  if(_formKey.currentState.validate()){
                    setState(()=> loading = true);
                    dynamic result = await _auth.register(email, password);
                    if(result == null){
                      setState(()=> error = 'Please enter valid info');
                      setState(()=> loading= false);
                    }

                    }
                  },
              ),
              SizedBox(height: 10.0),
              Text(error,
              style: TextStyle(
                color: Colors.red,
                fontSize: 14.0
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
