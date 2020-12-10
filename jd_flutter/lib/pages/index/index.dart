import 'package:flutter/material.dart';
import '../../view/JDMainPageTab.dart';

import '../cart/index.dart';
import '../category/index.dart';
import '../discover/index.dart';
import '../home/index.dart';


List<JDTabViewModel> modelList = [
  JDTabViewModel(title: '首页',widget: FinderFrameViewController()),
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

class JDMainPageViewController extends StatefulWidget {
  @override
  _JDMainPageViewControllerState createState() => _JDMainPageViewControllerState();
}

class _JDMainPageViewControllerState extends State<JDMainPageViewController> with SingleTickerProviderStateMixin{
  TabController tabController;

  @override
  void initState() {
    this.tabController = TabController(length: modelList.length, vsync: this);
    super.initState();
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

