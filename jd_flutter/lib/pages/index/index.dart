import 'package:flutter/material.dart';
import '../../view/JDMainPageTab.dart';
import '../../http/jd_http_service.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../cart/index.dart';
import '../category/index.dart';
import '../discover/index.dart';
import '../home/index.dart';
import 'JDMainPageViewController.dart';


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
  TabController tabController;

  @override
  void initState() {
    super.initState();
    this.tabController = TabController(length: modelList.length, vsync: this);

  }


  @override
  void dispose() {
    this.tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return JDPageTab(
      title: '首页',
      models: modelList,
      tabController: this.tabController,
    );
  }
}
