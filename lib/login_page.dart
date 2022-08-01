import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:learn_flutter_login/Menu.dart';
import 'package:learn_flutter_login/utlis/user_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final emailInput = TextEditingController();
  final passwordInput = TextEditingController();
  String tokenVal = '';
  late bool hidePassword;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    hidePassword = false;
    init();
  }

  Future init() async {
    final token = await UserSecureStorage.getToken() ?? '';
    if(token != null && token.isNotEmpty){
      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Menu()));
    }
    setState(() {
      this.tokenVal = token;
    });
  }

  void onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      callback();
    });
  }

  void loginValidation(BuildContext context) async {
    bool isLogin = true;
    FocusScope.of(context).requestFocus(FocusNode());

    if (emailInput.text.isEmpty) {
      isLogin = false;

      onWidgetDidBuild() {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Email must")));
      }
    }

    if (passwordInput.text.isEmpty) {
      isLogin = false;

      onWidgetDidBuild() {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Password must")));
      }
    }

    if (isLogin) {
      fetchLogin(context, emailInput.text, passwordInput.text);
    }
  }

  fetchLogin(BuildContext context, String email, String password) async {
    final pref = await SharedPreferences.getInstance();
    try {
      Response response;
      var dio = Dio();
      response = await dio.post(
        'https://reqres.in/api/login',
        data: {'email': email, 'password': password},
        options: Options(contentType: Headers.jsonContentType),
      );

      if (response.statusCode == 200) {
        String prefEmail = email;
        String prefToken = response.data['token'];
        await pref.setString('email', prefEmail);
        await pref.setString('token', prefToken);
        await UserSecureStorage.setToken(prefToken.toString());

        onWidgetDidBuild(() {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('login success')));
        });
      }

      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Menu()));

    } on DioError catch (e) {
      print("login gagal cuk");
    }
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
                    Text("asu"),
                    Text(tokenVal),
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
                onPressed: () {
                  loginValidation(context);
                },
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
