import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../http/jd_http_service.dart';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import '../config/jd_color_util.dart';

import 'index/index.dart';
import 'category//index.dart';
import 'cart//index.dart';
import 'discover//index.dart';
import 'home/index.dart';



class IndexCategoryDiscoverCartHome extends StatefulWidget {
  @override
  _IndexCategoryDiscoverCartHomeState createState() => _IndexCategoryDiscoverCartHomeState();
}

class _IndexCategoryDiscoverCartHomeState extends State<IndexCategoryDiscoverCartHome> {
  int selectedIndex = 0;
  Color backgroundColorNav = Colors.black54;

  List<JDBottomNavigationBarItem> items = [
    JDBottomNavigationBarItem("首页", "https://storage.360buyimg.com/mobileskin/ang1601381364121.png", "http://m.360buyimg.com/growthplanet/jfs/t1/130358/1/2751/6432/5ef09386Eeea4ae77/7a50d6f730838034.png", "#2E2D2D", "#E2231A"),
    JDBottomNavigationBarItem("分类", "http://m.360buyimg.com/growthplanet/jfs/t1/111779/36/11029/2626/5ef2cf4aE7b7ad25b/733e3670fd20cc9b.png", "http://m.360buyimg.com/growthplanet/jfs/t1/118628/38/10791/6392/5ef09414E0a994eb1/bbe0d845eaec3601.png", "#2E2D2D", "#E2231A"),
    JDBottomNavigationBarItem("发现", "http://m.360buyimg.com/growthplanet/jfs/t1/122778/8/5371/3884/5ef09444Edab6bde4/88794da24c262c0c.png", "http://m.360buyimg.com/growthplanet/jfs/t1/141268/12/1223/6860/5ef0941bE5da8c689/1a26ef2369c67ce1.png", "#2E2D2D", "#E2231A"),
    JDBottomNavigationBarItem("购物车", "http://m.360buyimg.com/growthplanet/jfs/t1/134597/4/2771/2914/5ef0944eEc5345dcb/1aef26fc796d33bd.png", "http://m.360buyimg.com/growthplanet/jfs/t1/141175/36/1236/6187/5ef09425E1f1b71cd/e635737841f1989f.png", "#2E2D2D", "#E2231A"),
    JDBottomNavigationBarItem("我的", "http://m.360buyimg.com/growthplanet/jfs/t1/117449/34/10644/3437/5ef09457Ef5b23b85/c18c244b20b86d64.png", "http://m.360buyimg.com/growthplanet/jfs/t1/146854/7/1281/5624/5ef0942cEb99b6251/c3c31a151c499fd8.png", "#2E2D2D", "#E2231A"),
  ];

  final List<Widget> tabBodies = [//要跳转的页面数组
    HomeIndex(),
    SHCategoryMainViewController(),
    FinderFrameViewController(),
    SCShopCartViewController(),
    MyJdHomeViewController(),
  ];//跳转页面数组

  Widget _buildItem(JDBottomNavigationBarItem jdItem, bool isSelected) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      padding: EdgeInsets.all(0.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CachedNetworkImage(imageUrl: isSelected ? jdItem.optlableImage : jdItem.lableImage, fit: BoxFit.fill,),
          Positioned(
            top: 35.0,
            child:  Text(
              jdItem.lableName,
              style: TextStyle(color: isSelected ? JDColor(jdItem.optlabelColor) : JDColor(jdItem.labelColor),fontSize: 12.0),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int itemIndex;
    return Scaffold(
      bottomNavigationBar: Container(
        height: 56,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: items.map((e) => GestureDetector(
            onTap: (){
              setState(() {
                itemIndex = items.indexOf(e);
                selectedIndex = items.indexOf(e);
              });
            },
            child: _buildItem(e, selectedIndex == items.indexOf(e)),
          )).toList(),
        ),
      ),
      body: tabBodies[selectedIndex],
    );
  }
}


class JDBottomNavigationBarItem {
  // final Image icon;
  final String lableName;
  final String lableImage;
  final String optlableImage;
  final String labelColor;
  final String optlabelColor;

  JDBottomNavigationBarItem(
      // this.icon,
      this.lableName,
      this.lableImage,
      this.optlableImage,
      this.labelColor,
      this.optlabelColor
      );
}

