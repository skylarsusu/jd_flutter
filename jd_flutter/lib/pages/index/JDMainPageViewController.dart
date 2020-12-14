import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:jd_flutter/pages/index/JDScrollableItem.dart';
import '../../http/jd_http_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../view/swiper.dart';
import '../../JDCostomWebView.dart';
import 'AppCenterItem.dart';
import 'JDHybridItem.dart';
import '../../config/jd_color_util.dart';
import 'JDScrollableItem.dart';
import '../../view/JDMainPageTab.dart';

class JDMainPageViewController extends StatefulWidget {
  @override
  _JDMainPageViewControllerState createState() => _JDMainPageViewControllerState();
}

class _JDMainPageViewControllerState extends State<JDMainPageViewController> with SingleTickerProviderStateMixin {
  bool isLoading = true;
  String response = '正在加载';

  List banner, topTab, appcenter, hybrid, scrollList = [];

  @override
  void initState() {
    super.initState();
    getHomeTabBarContent().then((value) {
        List floorList = value['floorList'];
        List<Widget> bannerList = List();//banner数组
        List<String> topTabList = List();//topTab数组
        List appCenterList = List();//中心滚动按钮数据数组
        String jumpUrl;
        Widget showImg;
        List<JDHybridItemModel> hybList = List();
        List<JDScrollableModel> srollL = List();

        floorList.forEach((element) {

          // 组中banner下方图形数据
          if(element['type'] == 'hybrid' && element['floorId'] == 8470){
            var content = element['content'];
            List subFloors = content['subFloors'];
            var model = subFloors[0];
            List data = model['data'];
            if(model['tpl'] == '08007'){
              data.forEach((element) {
                String tit  = element['title'];
                // print('title: $tit');
                JDScrollableModel model = JDScrollableModel(
                  title: element['title'],
                    titleColor: element['titleColor'],
                  img: CachedNetworkImage(imageUrl: element['img'], fit: BoxFit.scaleDown),
                  bgImg: CachedNetworkImage(imageUrl: element['bgImg'], fit: BoxFit.scaleDown),

                );
                srollL.add(model);
              });
            }

          }

          //组织中间位置滑动按钮数据
          if(element['type'] == 'appcenter'){
            var content = element['content'];
            List data = content['data'];
            List data1 = data.sublist(0,10);
            List data2 = data.sublist(10,20);
            List data3 = data.sublist(20,30);

            List<AppCenterItemModel> temp1 = List();
            List<AppCenterItemModel> temp2 = List();
            List<AppCenterItemModel> temp3 = List();

            data1.forEach((element) {
              AppCenterItemModel model = AppCenterItemModel(
                  icon: CachedNetworkImage(imageUrl: element['icon']),
                  title: element['name'],
              );
              temp1.add(model);
            });

            data2.forEach((element) {
              AppCenterItemModel model = AppCenterItemModel(
                icon: CachedNetworkImage(imageUrl: element['icon']),
                title: element['name'],
              );
              temp2.add(model);
            });

            data3.forEach((element) {
              AppCenterItemModel model = AppCenterItemModel(
                icon: CachedNetworkImage(imageUrl: element['icon']),
                title: element['name'],
              );
              temp3.add(model);
            });

            appCenterList.add(temp1);
            appCenterList.add(temp2);
            appCenterList.add(temp3);

          }

          //组织banner数据
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

          //组中banner下方图形数据
          if(element['type'] == 'hybrid'){
            var content = element['content'];
            List subFloors = content['subFloors'];

            subFloors.forEach((element) {
              if(element['tpl'] == '08009') {
                List data = element['data'];
                data.forEach((element1) {
                  String text = element1['subtitle'];

                  JDHybridItemModel model = JDHybridItemModel(
                      img: CachedNetworkImage(imageUrl: element1['img'], fit: BoxFit.scaleDown),
                    moduleBgImg: CachedNetworkImage(imageUrl: element1['moduleBgImg'], fit: BoxFit.scaleDown),
                    title: Text(text, style: TextStyle(fontSize: 12.0, color: JDColor('#ffffff'))),
                  );

                  hybList.add(model);
                });
              }

            });
          }


        });
        // response = value.toString();
        // print('response: $response');
       setState(() {
         banner = bannerList;
         appcenter = appCenterList;
         hybrid = hybList;
         scrollList = srollL;

         isLoading = false;
       });
    });
  }

  SliverList buildJDTabBar() {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index){
          return Container(
              color: Colors.yellow,

            child: TabBar(
              controller: this.tabController,
              isScrollable: true,
              tabs: modelList.map((e) => Text(e.title, style: TextStyle(fontSize: 20), )).toList(),
            ),
          );
        },childCount: 1)
    );
  }
  //轮播图
  SliverList buildSwiper() {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index){
          return SwiperView(banner,onTap,true);
        }, childCount: 1),
    );

  }

  //渲染appCenter组件
  SliverList buildCenterSwiper() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index){
        return SwiperView(makeupCenterData(), onTap, false);
      }, childCount: 1),
    );
  }

  List makeupCenterData() {
    List<Widget> data = List();
    appcenter.forEach((element) {
      data.add(AppCenterSwiper(modelList: element));
    });

    return data;
  }

  SliverList buildHybridView() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index){
        return JDHybridView(modelList: hybrid);
      }, childCount: 1),
    );

  }

  SliverList buildHybridScrollText() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index){
        return Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Text(
            '精选会场',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18,color: Colors.white),

          ),

          // child: Padding(
          //   padding: EdgeInsets.only(top: 10,left: 10.0),
          //   child: Text(
          //     '精选会场',
          //     textAlign: TextAlign.center,
          //     style: TextStyle(fontSize: 18,color: Colors.white),
          //
          //   ),
          // ),
        );
      }, childCount: 1),
    );

  }

  SliverList buildHybridScrollView() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index){
        return JdScrollableView(modelList: scrollList);
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
        buildHybridView(),
        buildCenterSwiper(),
        buildHybridScrollText(),
        buildHybridScrollView(),

      ];

      return CustomScrollView(
        slivers: sliverList,
      );
      return SafeArea(
          child: CustomScrollView(
            slivers: sliverList,
          ),
      );
    }
  }
}

List<JDTabViewModel> modelList = [
  JDTabViewModel(title: '首页',widget: JDMainPageViewController()),
  JDTabViewModel(title: '图书',widget: MyJdHomeViewController()),
  JDTabViewModel(title: '美妆',widget: SCShopCartViewController()),
  JDTabViewModel(title: '母婴童装',widget: SHCategoryMainViewController()),
  JDTabViewModel(title: '生鲜',widget: FinderFrameViewController()),
  JDTabViewModel(title: '玩具乐器',widget: MyJdHomeViewController()),
  JDTabViewModel(title: '食品',widget: SCShopCartViewController()),
  JDTabViewModel(title: '家具厨具',widget: SHCategoryMainViewController()),
  JDTabViewModel(title: '医药健康',widget: FinderFrameViewController()),
  JDTabViewModel(title: '手机',widget: MyJdHomeViewController()),
  JDTabViewModel(title: '男装',widget: SCShopCartViewController()),
  JDTabViewModel(title: '内衣配饰',widget: SHCategoryMainViewController()),
];
