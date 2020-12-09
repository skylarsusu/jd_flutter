import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../http/jd_http_service.dart';
import 'dart:convert';

import 'FinderFrameViewController.dart';
import 'JDMainPageViewController.dart';
import 'MyJdHomeViewController.dart';
import 'SCShopCartViewController.dart';
import 'SHCategoryMainViewController.dart';

//此页面为底部tabBar页面处理
class IndexCategoryDiscoverCartHome extends StatefulWidget {
  @override
  _IndexCategoryDiscoverCartHomeState createState() => _IndexCategoryDiscoverCartHomeState();
}

class _IndexCategoryDiscoverCartHomeState extends State<IndexCategoryDiscoverCartHome> {

  int _currentIndex = 0;//当前选择页面id
  Widget currentPage = null;//当前展示的页面

  final List tabBodies = [//要跳转的页面数组
    JDMainPageViewController(),
    SHCategoryMainViewController(),
    FinderFrameViewController(),
    SCShopCartViewController(),
    MyJdHomeViewController(),
  ];//跳转页面数组


  //处理服务器返回的数据
  List<Map>  _dealWithDataHandler(BuildContext context, var snapshot) {

    Map resultMap = snapshot.data['result'];
    // print(resultMap);
    Map modeMap = resultMap['modeMap'];
    Map style;
    if(modeMap['skinId'] == '0') {
      style = modeMap['normal'];
    } else {
      style = modeMap['dark'];
    }

    // print(style);
    List<Map> content = (style['navigationAll'] as List).cast();

    return content;

  }

  List<BottomNavigationBarItem> _setupBottomTabsData(List<Map> content, int currentIndex) {
    List<BottomNavigationBarItem> bottomTabs = [];//底部按钮数据数组

    var index = 0;
    content.forEach((element) {
      BottomNavigationBarItem item = BottomNavigationBarItem(
        icon: index == currentIndex ? Image.network(element['optlableImage']) : Image.network(element['lableName']),
        // icon: ImageIcon(index == currentIndex ? NetworkImage(element['optlableImage']) : NetworkImage(element['lableName'])),
        label: element['lableName'],

      );


      index += 1;
      bottomTabs.add(item);

    });

    return bottomTabs;
  }


  void onTapHandler(int index) {//点击后处理逻辑
    setState(() {
      _currentIndex = index;
      // currentPage =  tabBodies[index];
      print('Index == $index');
    });
  }

  static Color JDColor(String colorString, {double alpha = 1.0}) {
    String colorStr = colorString;
    // colorString未带0xff前缀并且长度为6
    if (!colorStr.startsWith('0xff') && colorStr.length == 6) {
      colorStr = '0xff' + colorStr;
    }
    // colorString为8位，如0x000000
    if(colorStr.startsWith('0x') && colorStr.length == 8) {
      colorStr = colorStr.replaceRange(0, 2, '0xff');
    }
    // colorString为7位，如#000000
    if(colorStr.startsWith('#') && colorStr.length == 7) {
      colorStr = colorStr.replaceRange(0, 1, '0xff');
    }
    // 先分别获取色值的RGB通道
    Color color = Color(int.parse(colorStr));
    int red = color.red;
    int green = color.green;
    int blue = color.blue;
    // 通过fromRGBO返回带透明度和RGB值的颜色
    return Color.fromRGBO(red, green, blue, alpha);
  }



  @override
  void initState() {
    // currentPage = tabBodies[_currentIndex];//未选择时默认展示页面

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        bottomNavigationBar: JDBottomNavigationBar(),
        body: tabBodies[_currentIndex],
      ),
    );
  }


}


class JDBottomNavigationBar extends StatefulWidget {
@override
_JDBottomNavigationBarState createState() => _JDBottomNavigationBarState();
}

class _JDBottomNavigationBarState extends State<JDBottomNavigationBar> {
  int selectedIndex = 0;
  Color backgroundColorNav = Colors.black54;

  List<JDBottomNavigationBarItem> items = [
    JDBottomNavigationBarItem("首页", "https://storage.360buyimg.com/mobileskin/ang1601381364121.png", "http://m.360buyimg.com/growthplanet/jfs/t1/130358/1/2751/6432/5ef09386Eeea4ae77/7a50d6f730838034.png", "#2E2D2D", "#E2231A"),
    JDBottomNavigationBarItem("分类", "https://storage.360buyimg.com/mobileskin/ang1601381364121.png", "http://m.360buyimg.com/growthplanet/jfs/t1/130358/1/2751/6432/5ef09386Eeea4ae77/7a50d6f730838034.png", "#2E2D2D", "#E2231A"),
    JDBottomNavigationBarItem("发现", "https://storage.360buyimg.com/mobileskin/ang1601381364121.png", "http://m.360buyimg.com/growthplanet/jfs/t1/130358/1/2751/6432/5ef09386Eeea4ae77/7a50d6f730838034.png", "#2E2D2D", "#E2231A"),
    JDBottomNavigationBarItem("购物车", "https://storage.360buyimg.com/mobileskin/ang1601381364121.png", "http://m.360buyimg.com/growthplanet/jfs/t1/130358/1/2751/6432/5ef09386Eeea4ae77/7a50d6f730838034.png", "#2E2D2D", "#E2231A"),
    JDBottomNavigationBarItem("我的", "https://storage.360buyimg.com/mobileskin/ang1601381364121.png", "http://m.360buyimg.com/growthplanet/jfs/t1/130358/1/2751/6432/5ef09386Eeea4ae77/7a50d6f730838034.png", "#2E2D2D", "#E2231A"),
  ];

  static Color JDColor(String colorString, {double alpha = 1.0}) {
    String colorStr = colorString;
    // colorString未带0xff前缀并且长度为6
    if (!colorStr.startsWith('0xff') && colorStr.length == 6) {
      colorStr = '0xff' + colorStr;
    }
    // colorString为8位，如0x000000
    if(colorStr.startsWith('0x') && colorStr.length == 8) {
      colorStr = colorStr.replaceRange(0, 2, '0xff');
    }
    // colorString为7位，如#000000
    if(colorStr.startsWith('#') && colorStr.length == 7) {
      colorStr = colorStr.replaceRange(0, 1, '0xff');
    }
    // 先分别获取色值的RGB通道
    Color color = Color(int.parse(colorStr));
    int red = color.red;
    int green = color.green;
    int blue = color.blue;
    // 通过fromRGBO返回带透明度和RGB值的颜色
    return Color.fromRGBO(red, green, blue, alpha);
  }

  Widget _buildItem(JDBottomNavigationBarItem jdItem, bool isSelected) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      padding: EdgeInsets.all(0.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.network(isSelected ? jdItem.optlableImage : jdItem.lableImage,
            fit: BoxFit.cover,
          ),
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
    return Container(
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


class ChangeViewProvider extends InheritedWidget {

  final int currentIndex;
  final Widget child;
  const ChangeViewProvider({
    this.currentIndex,
    this.child,
  })  : super(child: child);

  static ChangeViewProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ChangeViewProvider>();
  }

  @override
  bool updateShouldNotify(ChangeViewProvider old) {
    return true;
  }
}