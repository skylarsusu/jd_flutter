import 'package:flutter/material.dart';
import './pages/Index_Category_Discover_Cart_Home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '京东APP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        splashColor: Colors.white,

      ),
      home: IndexCategoryDiscoverCartHome(),
    );
  }



}
