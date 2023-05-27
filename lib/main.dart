import 'package:flutter/material.dart';
import 'package:tokoumb/helper/user_info.dart';
import 'package:tokoumb/ui/loginview.dart';
import 'package:tokoumb/ui/produkview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = const CircularProgressIndicator();

  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    var token = await UserInfo().getToken();
    setState(() {
      page = token != null ? ProdukView() : const LoginView();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toko UMB',
      debugShowCheckedModeBanner: false,
      home: page,
    );
  }
}
