
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
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
    );
  }
}
