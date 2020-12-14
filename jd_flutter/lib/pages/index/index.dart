import 'package:flutter/material.dart';
import '../../view/JDMainPageTab.dart';
import '../../http/jd_http_service.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../cart/index.dart';
import '../category/index.dart';
import '../discover/index.dart';
import '../home/index.dart';
import 'JDMainPageViewController.dart';
import '../../JDCostomWebView.dart';


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

class HomeIndex extends StatefulWidget {
  @override
  _HomeIndexState createState() => _HomeIndexState();
}

class _HomeIndexState extends State<HomeIndex> with SingleTickerProviderStateMixin{
  bool isLoading = true;
  TabController tabController;

  List<JDTabViewModel> tabList = [];
  JDCustomModel searchModel;
  JDCustomModel floatModel ;
  JDCustomModel topRotateModel ;


  @override
  void initState() {
    super.initState();
    this.tabController = TabController(length: modelList.length, vsync: this);

    getHomeTabBarContent().then((value) {
      List floorList = value['floorList'];
      List<JDTabViewModel> topTabList = List();//topTab数组
      String jumpUrl;
      Widget showImg;

      String floatJumpUrl;
      Widget floatShowImg;

      String topRotateJumpUrl;
      Widget topRotateImg;


      JDCustomModel _floatModel ;

      floorList.forEach((element) {

        if(element['type'] == 'topRotate'){
          var content = element['content'];
          List subFloors = content['subFloors'];
          var map = subFloors[0];
          List data = map['data'];
          var topRotate = data[0];
          topRotateImg = CachedNetworkImage(imageUrl: topRotate['img']);

          var jump = topRotate['jump'];
          var params = jump['params'];
          topRotateJumpUrl = params['url'];

        }
        if(element['type'] == 'float'){
          floatShowImg = CachedNetworkImage(imageUrl: element['img']);
          var jump = element['jump'];
          var params = jump['params'];
          floatJumpUrl = params['url'];

        }

        if(element['type'] == 'searchIcon'){
          showImg = CachedNetworkImage(imageUrl: element['img']);
          var jump = element['jump'];
          var params = jump['params'];
          jumpUrl = params['url'];

        }

        if(element['type'] == 'topTab'){
          List content = element['content'];
          content.forEach((element) {
            String title =  element['cName'];

            JDTabViewModel model = JDTabViewModel(title: element['cName'], widget: MyJdHomeViewController());
            topTabList.add(model);

          });
        }

      });
      // response = value.toString();
      // print('response: $response');
      setState(() {
        tabList = topTabList;
        searchModel = JDCustomModel(jumpUrl: jumpUrl, showImg: showImg);
        floatModel = JDCustomModel(jumpUrl: floatJumpUrl, showImg: floatShowImg);
        topRotateModel = JDCustomModel(jumpUrl: topRotateJumpUrl, showImg: topRotateImg);
        isLoading = false;
      });
    });
  }



  @override
  void dispose() {
    this.tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double _top = 0;

    if(isLoading) {
      return Center(
        child: SizedBox(
          width: 24.0,
          height: 24.0,
          child: CircularProgressIndicator(strokeWidth: 2.0,),
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('https://m.360buyimg.com/mobilecms/s1125x939_jfs/t1/138597/37/17558/80205/5fd0426cE6e553ab8/5df1ebbb6361a1ca.png'),
              fit: BoxFit.cover,
            )
        ),
        // child: Scaffold(
        //   backgroundColor: Colors.transparent,
        //   body: CustomScrollView(
        //     slivers: [
        //       SliverAppBar(
        //         backgroundColor: Colors.transparent,
        //
        //         // floating: true,
        //         pinned: true,
        //         // snap: true,
        //         expandedHeight: 48,
        //         // flexibleSpace: FlexibleSpaceBar(
        //         //   background: CachedNetworkImage(
        //         //     imageUrl: 'https://m.360buyimg.com/mobilecms/s1125x939_jfs/t1/138597/37/17558/80205/5fd0426cE6e553ab8/5df1ebbb6361a1ca.png',
        //         //     fit: BoxFit.cover,
        //         //   ),
        //         // ),
        //         elevation: 0.0,
        //         actions: [
        //           IconButton(icon: Icon(Icons.search), onPressed: (){
        //
        //           }),
        //           IconButton(icon: searchModel.showImg, onPressed: () {
        //             Navigator.push(context, MaterialPageRoute(builder: (context) {
        //               return JDCustomWebview(title: '北京消费券',url: searchModel.jumpUrl);
        //             }));
        //
        //           })
        //         ],
        //         // bottom: TabBar(
        //         //   tabs: modelList.map((e) => Text(e.title, style: TextStyle(fontSize: 20), )).toList(),
        //         //
        //         //   controller: this.tabController,
        //         //   isScrollable: true,
        //         //   onTap: (index) {
        //         //     print('index: $index');
        //         //     // Navigator.push(context, MaterialPageRoute(builder: (context) {
        //         //     //   return modelList[index].widget;
        //         //     // }));
        //         //   },
        //         // ),
        //       ),
        //       SliverFixedExtentList(
        //           delegate: SliverChildBuilderDelegate(
        //               (context, index) {
        //                 final isOdd = index % 2 == 1;
        //                 return Container(
        //
        //                   padding: EdgeInsets.only(left: 10.0, right: 10.0),
        //                   alignment: Alignment.center,
        //                   color: Colors.transparent,
        //
        //                   child: Column(
        //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //                     children: [
        //                       TabBar(
        //                         tabs: modelList.map((e) => Text(e.title, style: TextStyle(fontSize: 20), )).toList(),
        //
        //                         controller: this.tabController,
        //                         isScrollable: true,
        //                         onTap: (index) {
        //                           print('index: $index');
        //
        //                           // Navigator.push(context, MaterialPageRoute(builder: (context) {
        //                           //   return modelList[index].widget;
        //                           // }));
        //                         },
        //                       ),
        //                       TabBarView(
        //                           // children: [
        //                           //   JDMainPageViewController(),
        //                           // ],
        //                             controller: this.tabController,
        //                             children: modelList.map((e) => e.widget).toList(),
        //                       ),
        //                       Text(
        //                         index.toString(),
        //                         style: TextStyle(
        //                           fontSize: 30,
        //                           fontWeight: FontWeight.w500,
        //                           color: Colors.black,
        //                         ),
        //                       ),
        //                     ],
        //                   )
        //                   // Text(
        //                   //   index.toString(),
        //                   //   style: TextStyle(
        //                   //     fontSize: 30,
        //                   //     fontWeight: FontWeight.w500,
        //                   //     color: Colors.black,
        //                   //   ),
        //                   // ),
        //                 );
        //               },childCount: 1,
        //           ),
        //           itemExtent: 80,
        //       ),
        //     ],
        //   ),
        // ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            actions: [
              IconButton(icon: Icon(Icons.search), onPressed: (){

              }),
              IconButton(icon: searchModel.showImg, onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return JDCustomWebview(title: '北京消费券',url: searchModel.jumpUrl);
                }));

              })
            ],
            leading: Container(
              width: MediaQuery.of(context).size.width/2,
              height: 24,
              padding: EdgeInsets.only(left: 10.0),
              alignment: Alignment.centerLeft,
              child: topRotateModel.showImg,
            ),
            bottom: TabBar(
              controller: this.tabController,
              isScrollable: true,
              tabs: modelList.map((e) => Text(e.title, style: TextStyle(fontSize: 20), )).toList(),
            ),

          ),

          body: TabBarView(
            controller: this.tabController,
            children: modelList.map((e) => e.widget).toList(),
          ),

          floatingActionButton: Stack(

            children: [
              Positioned(
                width: 100.0,
                height: 100.0,
                bottom: _top,
                right: 0.0,
                child: GestureDetector(
                  child: floatModel.showImg,
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return JDCustomWebview(title: '北京消费券',url: floatModel.jumpUrl);
                    }));
                  },
                  onPanUpdate: (DragUpdateDetails e){
                    setState(() {
                      _top += e.delta.dy;
                    });
                  },
                  onPanEnd: (detail){
                    print('top: $_top');
                  },

                ),
              )
            ],
          ),
        ),
      );
    }



    return JDPageTab(
      title: '首页',
      models: modelList,
      tabController: this.tabController,
    );
  }
}


class JDCustomModel {
  final String jumpUrl;
  final Widget showImg;

  const JDCustomModel({
    this.jumpUrl,
    this.showImg,
  });
}