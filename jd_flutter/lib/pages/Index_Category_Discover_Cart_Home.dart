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

  final List tabBodies = [
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
        // icon: index == currentIndex ? Image.network(element['optlableImage']) : Image.network(element['lableName']),
        icon: ImageIcon(index == currentIndex ? NetworkImage(element['optlableImage']) : NetworkImage(element['lableName'])),
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



  @override
  void initState() {
    // currentPage = tabBodies[_currentIndex];//未选择时默认展示页面
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: FutureBuilder(
          future: getBottomTabBarContent(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              List<Map> content = _dealWithDataHandler(context, snapshot);
              return Scaffold(
                backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
                bottomNavigationBar: BottomNavigationBar(
                  // iconSize: 30.0,
                    unselectedFontSize: 8.0,
                  unselectedIconTheme: IconThemeData(size: 50.0),
                  selectedIconTheme:  IconThemeData(size: 50.0),
                  selectedFontSize: 8.0,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: _currentIndex,
                  items: _setupBottomTabsData(content, _currentIndex),
                  onTap: onTapHandler,

                ),
                body: tabBodies[_currentIndex],
              );

            } else {
              return Center(
                 child: Text('加载中...'),
              );
            }
          },
        )
      ),
    );
  }


}


//
// class MyBottomNavigationBarItem extends BottomNavigationBarItem {
//   final Widget icon;
//   final String label;
//   final String pageName;
// }

