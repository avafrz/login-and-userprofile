import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:loginandprofile/model/users.dart';
import 'package:loginandprofile/screens/profile_screen.dart';
import 'package:loginandprofile/services/api_handler.dart';
import '../widgets/textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late Future<List<Users>> futureUsers;

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   futureUsers = ApiHandler().fetchUsers();
  //   super.didChangeDependencies();
  // }
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   futureUsers = ApiHandler().fetchUsers();
  // }

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.bottomLeft,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Container(
                height: constraints.maxHeight * 1 / 2,
                width: constraints.maxWidth,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(200),
                  ),
                  color: Colors.blue,
                ),
              ),
            ),
            Center(
              child: Container(
                width: constraints.maxWidth * 0.82,
                height: constraints.maxHeight * 0.86,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 4,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: constraints.maxWidth * 0.38,
                        height: constraints.maxHeight * 0.15,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(120),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 8,
                          top: 15,
                        ),
                        child: Text(
                          'Welcome!',
                          style: TextStyle(
                            fontSize: 28,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 10,
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextFieldWidget(
                        'Username',
                        'Your Name',
                        usernameController,
                        (value) {
                          if (value == null || value.isEmpty) {
                            return "* Required";
                          }
                          return null;
                        },
                      ),
                      TextFieldWidget(
                        'Password',
                        'Password',
                        passwordController,
                        (value) {
                          if (value == null || value.isEmpty) {
                            return "* Required";
                          } else if (value.length < 6) {
                            return "Password should be atleast 6 characters";
                          }
                          return null;
                        },
                      ),
                      FutureBuilder(
                          future: ApiHandler().fetchUsers(),
                          builder: (context, snapshot) {
                            return Center(
                              child: ElevatedButton(
                                onPressed: () async {
                                  print(ApiHandler().fetchUsers());
                                  if (_formKey.currentState!.validate()) {
                                    if (snapshot.hasData) {
                                      for (var i = 0;
                                          i < snapshot.data!.length;
                                          i++) {
                                        if (snapshot.data![i].username ==
                                                usernameController.text &&
                                            snapshot.data![i].password ==
                                                passwordController.text) {
                                          setState(() {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content:
                                                  Text('login was successful'),
                                            ));
                                            usernameController.text = '';
                                            passwordController.text = '';
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProfileScreen(i),
                                              ),
                                            );
                                          });
                                        }
                                      }
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  elevation: 0,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.only(
                                    top: 15,
                                    bottom: 10,
                                    left: 20,
                                    right: 20,
                                  ),
                                  child: Text(
                                    'LOG IN',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                      const SizedBox(
                        height: 18,
                      ),
                      const Center(
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account?',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Create Account',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
