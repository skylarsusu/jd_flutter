import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../http/jd_http_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../view/swiper.dart';
import '../../JDCostomWebView.dart';

class JDMainPageViewController extends StatefulWidget {
  @override
  _JDMainPageViewControllerState createState() => _JDMainPageViewControllerState();
}

class _JDMainPageViewControllerState extends State<JDMainPageViewController> with SingleTickerProviderStateMixin {
  bool isLoading = true;
  String response = '正在加载';

  List banner, topTab = [];

  @override
  void initState() {
    super.initState();
    getHomeTabBarContent().then((value) {
        List floorList = value['floorList'];
        List<Widget> bannerList = List();//banner数组
        List<String> topTabList = List();//topTab数组
        String jumpUrl;
        Widget showImg;

        floorList.forEach((element) {


          if(element['type'] == 'banner'){
            List content = element['content'];
            content.forEach((element) {
              bannerList.add(
                ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: element['horizontalImag'],
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(10),
                )

              );
            });
          }

        });
        // response = value.toString();
        // print('response: $response');
       setState(() {
         banner = bannerList;

         isLoading = false;
       });
    });
  }

  //轮播图
  SliverList buildSwiper(){
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index){
          return SwiperView(banner,onTap);
        }, childCount: 1),
    );

  }

  onTap(int index){
    print('点击了第$index张图片');
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return JDCustomWebview(title: 'Demo',url: 'https://prodev.m.jd.com/mall/active/2hT2gWWUWAANbs7Dio1wyrjFvKoq/index.html');
      }));

  }

  @override
  Widget build(BuildContext context) {
    if(isLoading) {
      return Center(
        child: SizedBox(
          width: 24.0,
          height: 24.0,
          child: CircularProgressIndicator(strokeWidth: 2.0,),
        ),
      );
    } else {
      var sliverList = [
        buildSwiper(),
      ];

      return
        SafeArea(
          child: CustomScrollView(
            slivers: sliverList,
          ),
      );
    }
  }
}

