import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class JDBottomNavigationBar extends StatefulWidget {
  @override
  _JDBottomNavigationBarState createState() => _JDBottomNavigationBarState();
}

class _JDBottomNavigationBarState extends State<JDBottomNavigationBar> {
  int selectedIndex = 0;
  Color backgroundColorNav = Colors.white;

  List<JDBottomNavigationBarItem> items = [
    JDBottomNavigationBarItem("首页", "https://storage.360buyimg.com/mobileskin/ang1601381364121.png", "http://m.360buyimg.com/growthplanet/jfs/t1/130358/1/2751/6432/5ef09386Eeea4ae77/7a50d6f730838034.png", "#2E2D2D", "#E2231A");
    JDBottomNavigationBarItem("分类", "https://storage.360buyimg.com/mobileskin/ang1601381364121.png", "http://m.360buyimg.com/growthplanet/jfs/t1/130358/1/2751/6432/5ef09386Eeea4ae77/7a50d6f730838034.png", "#2E2D2D", "#E2231A");
    JDBottomNavigationBarItem("发现", "https://storage.360buyimg.com/mobileskin/ang1601381364121.png", "http://m.360buyimg.com/growthplanet/jfs/t1/130358/1/2751/6432/5ef09386Eeea4ae77/7a50d6f730838034.png", "#2E2D2D", "#E2231A");
    JDBottomNavigationBarItem("购物车", "https://storage.360buyimg.com/mobileskin/ang1601381364121.png", "http://m.360buyimg.com/growthplanet/jfs/t1/130358/1/2751/6432/5ef09386Eeea4ae77/7a50d6f730838034.png", "#2E2D2D", "#E2231A");
    JDBottomNavigationBarItem("我的", "https://storage.360buyimg.com/mobileskin/ang1601381364121.png", "http://m.360buyimg.com/growthplanet/jfs/t1/130358/1/2751/6432/5ef09386Eeea4ae77/7a50d6f730838034.png", "#2E2D2D", "#E2231A");
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
       height: 50,
      width: 50,
        padding: EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageIcon(NetworkImage(isSelected ? jdItem.optlableImage : jdItem.lableImage)),
          Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                jdItem.lableName,
                style: TextStyle(color: isSelected ? JDColor(jdItem.optlabelColor) : JDColor(jdItem.labelColor)),
              ),
          )

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: EdgeInsets.only(left: 8, top: 4, bottom: 4, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: items.map((e) => GestureDetector(
          var itemIndex = items.indexOf(e);
          onTap: (){
            setState(() {
              selectedIndex = itemIndex;
            });
          },
          child: _buildItem(e, selectedIndex == itemIndex),
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