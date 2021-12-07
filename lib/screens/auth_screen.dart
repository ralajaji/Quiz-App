import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teacher_app/component/text_field_container.dart';
import '../constants.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    AuthMode _authMode = AuthMode.Login;

    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/signup_top.png",
              width: deviceSize.width * 0.35,
            ),
          ),
          Align(
            alignment: Alignment(0, -0.67),
            child: SvgPicture.asset(
              "assets/icons/signup.svg",
              height: deviceSize.height * 0.35,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/images/login_bottom.png",
              width: deviceSize.width * 0.4,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final IconData icon;
  final ValueChanged<String> onChanged;
  String errorMessage;
  final _storage = FlutterSecureStorage();
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  _AuthCardState({
    this.icon = Icons.person,
    this.onChanged,
  });
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();

  saveUser(String id) async {
    var url =
        "https://quiz-ksu-default-rtdb.asia-southeast1.firebasedatabase.app/users/${id}.json";
    final res = await http.put(Uri.parse(url),
        body: json.encode({
          "user": {"points": 0, "name": _nameController.text}
        }));
    final body = json.decode(res.body);
    print(body);
  }

  void _submit() async {
    setState(() {
      errorMessage = null;
    });
    setState(() {
      _isLoading = true;
    });
    if (_authMode == AuthMode.Login) {
      // Log user in
      const url =
          "https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyBEySMXRmH7wYJle8KepHLONtHmwNGfjbY";
      final res = await http.post(Uri.parse(url),
          body: json.encode({
            'email': _emailController.text,
            'password': _passwordController.text,
            'returnSecureToken': true
          }));
      final body = json.decode(res.body);
      final id = body['localId'];
      print(id); // null in case wrong
      if (id == null) {
        errorMessage = 'The email and password you entered do not match';
        // showDialog<String>(
        //   context: context,
        //   builder: (BuildContext context) => AlertDialog(
        //     title: Text(error),
        //     content: const Text('try again'),
        //     actions: <Widget>[
        //       TextButton(
        //         onPressed: () => Navigator.pop(context, 'Cancel'),
        //         child: const Text('Cancel'),
        //       ),
        //       TextButton(
        //         onPressed: () => Navigator.pop(context, 'OK'),
        //         child: const Text('OK'),
        //       ),
        //     ],
        //   ),
        // );
      }
      if (id != null) {
        final email = _emailController.text;
        final url = 'https://mutamimon.com/381/forget.php?email=$email';
        await http.get(Uri.parse(url));
        await _storage.write(
          key: 'token',
          value: id,
        );

        Navigator.pushNamed(context, '/home');
      }
    } else {
      const url =
          "https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AIzaSyBEySMXRmH7wYJle8KepHLONtHmwNGfjbY";
      final res = await http.post(Uri.parse(url),
          body: json.encode({
            'email': _emailController.text,
            'password': _passwordController.text,
            'returnSecureToken': true
          }));

      final body = json.decode(res.body);
      final id = body['localId'];
      if (id == null) {
        errorMessage = '';
        if (body['error']['message'] == 'INVALID_EMAIL') {
          errorMessage = 'you should enter a valid email';
        } else {
          errorMessage = 'password must have 6 characters at least';
        }
        // showDialog<String>(
        //   context: context,
        //   builder: (BuildContext context) => AlertDialog(
        //     title: Text(error),
        //     content: const Text('try again'),
        //     actions: <Widget>[
        //       TextButton(
        //         onPressed: () => Navigator.pop(context, 'Cancel'),
        //         child: const Text('Cancel'),
        //       ),
        //       TextButton(
        //         onPressed: () => Navigator.pop(context, 'OK'),
        //         child: const Text('OK'),
        //       ),
        //     ],
        //   ),
        // );
      }
      if (id != null) {
        await _storage.write(
          key: 'token',
          value: id,
        );
        saveUser(id);
        Navigator.pushNamed(context, '/home');
      }
      // Sign user up
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Stack(children: <Widget>[
      Align(
        alignment: Alignment(0, -0.85),
        child: Text(
          _authMode == AuthMode.Login ? 'LOGIN' : 'SIGNUP',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        alignment: Alignment(0, 0.75),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  errorMessage == null ? '' : "*$errorMessage",
                  style: TextStyle(
                    color: Colors.red.shade900,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFieldContainer(
                  child: TextField(
                    controller: _emailController,
                    onChanged: onChanged,
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      icon: Icon(
                        icon,
                        color: kPrimaryColor,
                      ),
                      hintText: "Your Email",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (_authMode == AuthMode.Signup)
                  TextFieldContainer(
                    child: TextField(
                      enabled: _authMode == AuthMode.Signup,
                      controller: _nameController,
                      onChanged: onChanged,
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        icon: Icon(
                          icon,
                          color: kPrimaryColor,
                        ),
                        hintText: "Your Name",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                TextFieldContainer(
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    onChanged: onChanged,
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      hintText: "Password",
                      icon: Icon(
                        Icons.lock,
                        color: kPrimaryColor,
                      ),
                      suffixIcon: Icon(
                        Icons.visibility,
                        color: kPrimaryColor,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (_authMode == AuthMode.Signup)
                  TextFieldContainer(
                    child: TextFormField(
                      enabled: _authMode == AuthMode.Signup,
                      obscureText: true,
                      validator: _authMode == AuthMode.Signup
                          ? (value) {
                              if (value != _passwordController.text) {
                                return 'Passwords do not match!';
                              }
                            }
                          : null,
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
                        icon: Icon(
                          Icons.lock,
                          color: kPrimaryColor,
                        ),
                        suffixIcon: Icon(
                          Icons.visibility,
                          color: kPrimaryColor,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: deviceSize.width * 0.8,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(29),
                            child: ElevatedButton(
                              child: Text(
                                _authMode == AuthMode.Login
                                    ? 'LOGIN'
                                    : 'SIGN UP',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: _submit,
                              style: ElevatedButton.styleFrom(
                                  primary: kPrimaryColor,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 20),
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              _authMode == AuthMode.Login
                                  ? "Don’t have an Account ? "
                                  : "Already have an Account ? ",
                              style: TextStyle(color: kPrimaryColor),
                            ),
                            GestureDetector(
                              onTap: _switchAuthMode,
                              child: Text(
                                _authMode == AuthMode.Login
                                    ? "SIGNUP"
                                    : "LOGIN",
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      )
    ]);
  }
}
