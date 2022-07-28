import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final emailInput = TextEditingController();
  final passwordInput = TextEditingController();
  late bool hidePassword;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    hidePassword = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Card(
              elevation: 12,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text("Login"),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    elevation: 2,
                    child: AspectRatio(
                      aspectRatio: 7 / 1,
                      child: Center(
                          child: TextFormField(
                        decoration: InputDecoration(hintText: 'Email'),
                        controller: emailInput,
                        keyboardType: TextInputType.emailAddress,
                      )),
                    ),
                  ),
                  Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    elevation: 2,
                    child: AspectRatio(
                      aspectRatio: 7 / 1,
                      child: Center(
                          child: TextFormField(
                        decoration: InputDecoration(hintText: 'Password'),
                        controller: passwordInput,
                        keyboardType: TextInputType.text,
                        obscureText: hidePassword,
                      )),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              width: MediaQuery.of(context).size.width,
              child: MaterialButton(
                onPressed: () {},
                child: Text("Login now"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              width: MediaQuery.of(context).size.width,
              child: MaterialButton(
                onPressed: () {},
                child: Text("Sign up now"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              width: MediaQuery.of(context).size.width,
              child: MaterialButton(
                onPressed: () {},
                child: Text("Forgot password"),
              ),
            )
          ],
          
        ),
      ),
    );
  }
}
