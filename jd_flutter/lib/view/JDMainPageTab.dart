
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';



class JDTabViewModel {
  final String title;
  final Widget widget;

  const JDTabViewModel({
    this.title,
    this.widget,
});
}

class JDPageTab extends StatelessWidget {
  final String title;
  final List<JDTabViewModel> models;
  final bool tabScrollable;
  final TabController tabController;

  JDPageTab({
   this.title,
   this.models,
   this.tabScrollable = true,
   this.tabController,
});

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://m.360buyimg.com/mobilecms/s1125x939_jfs/t1/138597/37/17558/80205/5fd0426cE6e553ab8/5df1ebbb6361a1ca.png'),
            fit: BoxFit.cover,
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(this.title),
          actions: [
            IconButton(icon: Icon(Icons.search), onPressed: (){

            }),


          ],
          bottom: TabBar(
            controller: this.tabController,
            isScrollable: this.tabScrollable,
            tabs: this.models.map((e) => Text(e.title, style: TextStyle(fontSize: 20), )).toList(),
          ),

        ),

        body: TabBarView(
              controller: this.tabController,
              children: this.models.map((e) => e.widget).toList(),
            ),

      ),
    );
  }
}


class JDAppBar extends AppBar{
  final Widget backgroundImage ;
  final String titleStr;
  final List<JDTabViewModel> models;
  final bool tabScrollable;
  final TabController tabController;
  JDAppBar({
    this.backgroundImage,
    this.titleStr,
    this.models,
    this.tabScrollable,
    this.tabController,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // this.backgroundImage,
        AppBar(
          actions: [
            IconButton(icon: Icon(Icons.search), onPressed: (){

            }),
          ],
          bottom: TabBar(
            controller: this.tabController,
            isScrollable: this.tabScrollable,
            tabs: this.models.map((e) => Text(e.title, style: TextStyle(fontSize: 20), )).toList(),
          ),
        )
      ],
    );
  }
}


