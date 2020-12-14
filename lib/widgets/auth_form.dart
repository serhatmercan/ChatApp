import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn);

  final void Function(String email, String password, String username, bool isLogin, BuildContext ctx) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = "";
  var _userName = "";
  var _userPassword = "";

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();

    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: "Email"),
                    key: ValueKey("email"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty || !value.contains("@")) {
                        return "Email must be contains @ character";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _userEmail = value;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      decoration: InputDecoration(labelText: "Username"),
                      key: ValueKey("username"),
                      validator: (value) {
                        if (value.isEmpty || value.length < 4) {
                          return "Username must be at least 4 characters long";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _userName = value;
                      },
                    ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Password"),
                    key: ValueKey("password"),
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty || value.length < 7) {
                        return "Password must be at least 7 characters long";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _userPassword = value;
                    },
                  ),
                  SizedBox(height: 12),
                  RaisedButton(
                    onPressed: _trySubmit,
                    child: Text(
                      _isLogin ? "Login" : "Signup",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(_isLogin ? "Create New Account" : "I already have an account"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
